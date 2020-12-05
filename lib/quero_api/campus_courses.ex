defmodule QueroApi.CampusCourses do
  @moduledoc """
  The CampusCourses context.
  """

  import Ecto.Query, warn: false
  alias QueroApi.Repo

  alias QueroApi.CampusCourses.CampusCourse

  @doc """
  Returns the list of campus_courses.

  ## Examples

      iex> list_campus_courses()
      [%CampusCourse{}, ...]

  """
  def list_campus_courses do
    Repo.all(CampusCourse)
  end

  @doc """
  Gets a single campus_course.

  Raises `Ecto.NoResultsError` if the Campus course does not exist.

  ## Examples

      iex> get_campus_course!(123)
      %CampusCourse{}

      iex> get_campus_course!(456)
      ** (Ecto.NoResultsError)

  """
  def get_campus_course!(id), do: Repo.get!(CampusCourse, id)

  @doc """
  Creates a campus_course.

  ## Examples

      iex> create_campus_course(%{field: value})
      {:ok, %CampusCourse{}}

      iex> create_campus_course(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_campus_course(attrs \\ %{}) do
    %CampusCourse{}
    |> CampusCourse.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a campus_course.

  ## Examples

      iex> update_campus_course(campus_course, %{field: new_value})
      {:ok, %CampusCourse{}}

      iex> update_campus_course(campus_course, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_campus_course(%CampusCourse{} = campus_course, attrs) do
    campus_course
    |> CampusCourse.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a campus_course.

  ## Examples

      iex> delete_campus_course(campus_course)
      {:ok, %CampusCourse{}}

      iex> delete_campus_course(campus_course)
      {:error, %Ecto.Changeset{}}

  """
  def delete_campus_course(%CampusCourse{} = campus_course) do
    Repo.delete(campus_course)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking campus_course changes.

  ## Examples

      iex> change_campus_course(campus_course)
      %Ecto.Changeset{data: %CampusCourse{}}

  """
  def change_campus_course(%CampusCourse{} = campus_course, attrs \\ %{}) do
    CampusCourse.changeset(campus_course, attrs)
  end
end
