defmodule QueroApi.Courses do
  @moduledoc """
  The Courses context.
  """

  import Ecto.Query, warn: false
  alias QueroApi.Repo

  alias QueroApi.Courses.Course

  alias QueroApi.CacheCourses

  @doc """
  Returns the list of courses.

  ## Examples

      iex> list_courses()
      [%Course{}, ...]

  """
  def list_courses do
    Repo.all(Course)
  end

  @doc """
  Returns the list of course, campus and university maps from the cache

  ## Examples

      iex> list_all_in_courses([kind: "presencial", level: "", university: "unip", shift: "noite"])
      [%{course: %Course{}, campus: %Campu{}, university: %University{}}, ...]

  """
  def list_all_in_courses(discretion) when is_list(discretion) do
    data = CacheCourses.get()

    case data do
      [] ->
        list_all_in_courses_to_db()
        data = CacheCourses.get()

        filter(discretion, data)

      _ ->
        filter(discretion, data)
    end
  end

  defp filter(params, data) do
    Enum.reduce(params, data, fn
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
    end)
  end

  defp standardize(params) do
    params
    |> String.normalize(:nfd)
    |> String.downcase()
    |> String.replace(~r/[^A-z\s]/u, "")
  end

  @doc """
  Returns the list of maps of courses, campuses and universities from the database

  ## Examples

      iex> list_all_in_courses_to_db([kind: "presencial", level: "", university: "unip", shift: "noite"])
      [%{course: %Course{}, campus: %Campu{}, university: %University{}}, ...]

  """
  def list_all_in_courses_to_db do
    query =
      from cs in QueroApi.Courses.Course,
        left_join: ccs in QueroApi.CampusCourses.CampusCourse,
        on: cs.id == ccs.course_id,
        left_join: c in QueroApi.Campus.Campu,
        on: c.id == ccs.campu_id,
        join: u in QueroApi.Universities.University,
        on: u.id == c.university_id

    query =
      from [cs, ccs, c, u] in query,
        select: %{course: cs, campus: c, university: u}

    Repo.all(query) |> CacheCourses.insert()
  end

  @doc """
  Gets a single course.

  Raises `Ecto.NoResultsError` if the Course does not exist.

  ## Examples

      iex> get_course!(123)
      %Course{}

      iex> get_course!(456)
      ** (Ecto.NoResultsError)

  """
  def get_course!(id), do: Repo.get!(Course, id)

  @doc """
  Creates a course.

  ## Examples

      iex> create_course(%{field: value})
      {:ok, %Course{}}

      iex> create_course(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_course(attrs \\ %{}) do
    %Course{}
    |> Course.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a course.

  ## Examples

      iex> update_course(course, %{field: new_value})
      {:ok, %Course{}}

      iex> update_course(course, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_course(%Course{} = course, attrs) do
    course
    |> Course.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a course.

  ## Examples

      iex> delete_course(course)
      {:ok, %Course{}}

      iex> delete_course(course)
      {:error, %Ecto.Changeset{}}

  """
  def delete_course(%Course{} = course) do
    Repo.delete(course)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking course changes.

  ## Examples

      iex> change_course(course)
      %Ecto.Changeset{data: %Course{}}

  """
  def change_course(%Course{} = course, attrs \\ %{}) do
    Course.changeset(course, attrs)
  end
end
