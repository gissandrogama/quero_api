defmodule QueroApi.Offers do
  @moduledoc """
  The Offers context.
  """

  import Ecto.Query, warn: false
  alias QueroApi.Repo

  alias QueroApi.Offers.Offer

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
  Returns the list of lists of courses, campus and universities.

  ## Examples

      iex> list_all_in_offers()
      [[offer: %Offer{}, course: %Course{}, campus: %Campu{}, university: %University{}], ...]

  """
  def list_all_in_offers(discretion) when is_list(discretion) do
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
        select: [offer: of, course: cs, campus: c, university: u]

    Enum.reduce(discretion, query, fn
      {:city, ""}, query ->
        query

      {:city, city}, query ->
        from [of, cof, cs, ccs, c, u] in query, where: ilike(c.city, ^city)

      {:course, ""}, query ->
        query

      {:course, course}, query ->
        from [of, cof, cs, ccs, c, u] in query, where: ilike(cs.name, ^course)

      {:kind, ""}, query ->
        query

      {:kind, kind}, query ->
        from [of, cof, cs, ccs, c, u] in query, where: ilike(cs.kind, ^kind)

      {:level, ""}, query ->
        query

      {:level, level}, query ->
        from [of, cof, cs, ccs, c, u] in query, where: ilike(cs.level, ^level)

      {:university, ""}, query ->
        query

      {:university, university}, query ->
        from [of, cof, cs, ccs, c, u] in query, where: ilike(u.name, ^university)

      {:shift, ""}, query ->
        query

      {:shift, shift}, query ->
        from [of, cof, cs, ccs, c, u] in query, where: ilike(cs.shift, ^shift)

      {:prices, ""}, query ->
        query

      {:prices, prices}, query ->
        case prices do
          "maior" ->
            from q in query, order_by: [desc: q.price_with_discount]
          "menor" ->
            from q in query, order_by: [asc: q.price_with_discount]
        end
    end)
    |> Repo.all()
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
