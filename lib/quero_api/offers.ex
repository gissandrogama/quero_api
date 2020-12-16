defmodule QueroApi.Offers do
  @moduledoc """
  The Offers context.
  """

  import Ecto.Query, warn: false

  alias QueroApi.{CacheOffers, Offers.Offer, Repo}

  @doc """
  Returns the list of offers.

  ## Examples

      iex> list_offers()
      [%Offer{}, ...]

  """
  def list_offers do
    Repo.all(Offer)
  end

  @doc """
   Returns the list of courses, campuses, offers and university maps from the cache

  ## Examples

      iex> list_all_in_offers()
      [%{offer: %Offer{}, course: %Course{}, campus: %Campu{}, university: %University{}}, ...]

  """
  def list_all_in_offers(discretion) when is_list(discretion) do
    data = CacheOffers.get()

    case data do
      [] ->
        list_all_in_offers_to_db()
        data = CacheOffers.get()

        filter(discretion, data)

      _ ->
        filter(discretion, data)
    end
  end

  def filter(params, data) do
    Enum.reduce(params, data, fn
      {:city, ""}, data ->
        data

      {:city, city}, data ->
        Enum.filter(data, fn data -> standardize(data.campus.city) == standardize(city) end)

      {:course, ""}, data ->
        data

      {:course, course}, data ->
        Enum.filter(data, fn data -> standardize(data.course.name) == standardize(course) end)

      {:kind, ""}, data ->
        data

      {:kind, kind}, data ->
        Enum.filter(data, fn data -> standardize(data.course.kind) == standardize(kind) end)

      {:level, ""}, data ->
        data

      {:level, level}, data ->
        Enum.filter(data, fn data -> standardize(data.course.level) == standardize(level) end)

      {:university, ""}, data ->
        data

      {:university, university}, data ->
        Enum.filter(data, fn data ->
          standardize(data.university.name) == standardize(university)
        end)

      {:shift, ""}, data ->
        data

      {:shift, shift}, data ->
        Enum.filter(data, fn data -> standardize(data.course.shift) == standardize(shift) end)

      {:prices, ""}, data ->
        data

      {:prices, prices}, data ->
        case prices do
          "maior" ->
            Enum.sort_by(data, & &1.offer.price_with_discount, :desc)

          "menor" ->
            Enum.sort_by(data, & &1.offer.price_with_discount, :asc)
        end
    end)
  end

  defp standardize(params) do
    params
    |> String.normalize(:nfd)
    |> String.downcase()
    |> String.replace(~r/[^A-z\s]/u, "")
  end

  @doc """
  Returns the list of maps of offers, campuses, courses and universities from the database

  ## Examples

      iex> list_all_in_courses_to_db([kind: "presencial", level: "", university: "unip", shift: "noite"])
      [%{offer: %Offer{}, course: %Course{}, campus: %Campu{}, university: %University{}}, ...]

  """
  def list_all_in_offers_to_db do
    query =
      from of in QueroApi.Offers.Offer,
        join: cof in QueroApi.CoursesOffers.CoursesOffer,
        on: of.id == cof.offer_id,
        join: cs in QueroApi.Courses.Course,
        on: cs.id == cof.course_id,
        join: ccs in QueroApi.CampusCourses.CampusCourse,
        on: cs.id == ccs.course_id,
        join: c in QueroApi.Campus.Campu,
        on: c.id == ccs.campu_id,
        join: u in QueroApi.Universities.University,
        on: u.id == c.university_id

    query =
      from [of, cof, cs, ccs, c, u] in query,
        select: %{offer: of, course: cs, campus: c, university: u}

    Repo.all(query) |> CacheOffers.insert()
  end

  @doc """
  Gets a single offer.

  Raises `Ecto.NoResultsError` if the Offer does not exist.

  ## Examples

      iex> get_offer!(123)
      %Offer{}

      iex> get_offer!(456)
      ** (Ecto.NoResultsError)

  """
  def get_offer!(id), do: Repo.get!(Offer, id)

  @doc """
  Creates a offer.

  ## Examples

      iex> create_offer(%{field: value})
      {:ok, %Offer{}}

      iex> create_offer(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_offer(attrs \\ %{}) do
    %Offer{}
    |> Offer.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a offer.

  ## Examples

      iex> update_offer(offer, %{field: new_value})
      {:ok, %Offer{}}

      iex> update_offer(offer, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_offer(%Offer{} = offer, attrs) do
    offer
    |> Offer.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a offer.

  ## Examples

      iex> delete_offer(offer)
      {:ok, %Offer{}}

      iex> delete_offer(offer)
      {:error, %Ecto.Changeset{}}

  """
  def delete_offer(%Offer{} = offer) do
    Repo.delete(offer)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking offer changes.

  ## Examples

      iex> change_offer(offer)
      %Ecto.Changeset{data: %Offer{}}

  """
  def change_offer(%Offer{} = offer, attrs \\ %{}) do
    Offer.changeset(offer, attrs)
  end
end
