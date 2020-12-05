defmodule QueroApi.CoursesOffers do
  @moduledoc """
  The CoursesOffers context.
  """

  import Ecto.Query, warn: false
  alias QueroApi.Repo

  alias QueroApi.CoursesOffers.CoursesOffer

  @doc """
  Returns the list of courses_offers.

  ## Examples

      iex> list_courses_offers()
      [%CoursesOffer{}, ...]

  """
  def list_courses_offers do
    Repo.all(CoursesOffer)
  end

  @doc """
  Gets a single courses_offer.

  Raises `Ecto.NoResultsError` if the Courses offer does not exist.

  ## Examples

      iex> get_courses_offer!(123)
      %CoursesOffer{}

      iex> get_courses_offer!(456)
      ** (Ecto.NoResultsError)

  """
  def get_courses_offer!(id), do: Repo.get!(CoursesOffer, id)

  @doc """
  Creates a courses_offer.

  ## Examples

      iex> create_courses_offer(%{field: value})
      {:ok, %CoursesOffer{}}

      iex> create_courses_offer(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_courses_offer(attrs \\ %{}) do
    %CoursesOffer{}
    |> CoursesOffer.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a courses_offer.

  ## Examples

      iex> update_courses_offer(courses_offer, %{field: new_value})
      {:ok, %CoursesOffer{}}

      iex> update_courses_offer(courses_offer, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_courses_offer(%CoursesOffer{} = courses_offer, attrs) do
    courses_offer
    |> CoursesOffer.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a courses_offer.

  ## Examples

      iex> delete_courses_offer(courses_offer)
      {:ok, %CoursesOffer{}}

      iex> delete_courses_offer(courses_offer)
      {:error, %Ecto.Changeset{}}

  """
  def delete_courses_offer(%CoursesOffer{} = courses_offer) do
    Repo.delete(courses_offer)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking courses_offer changes.

  ## Examples

      iex> change_courses_offer(courses_offer)
      %Ecto.Changeset{data: %CoursesOffer{}}

  """
  def change_courses_offer(%CoursesOffer{} = courses_offer, attrs \\ %{}) do
    CoursesOffer.changeset(courses_offer, attrs)
  end
end
