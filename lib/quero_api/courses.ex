defmodule QueroApi.Courses do
  @moduledoc """
  The Courses context.
  """

  import Ecto.Query, warn: false
  alias QueroApi.Repo

  alias QueroApi.Courses.Course

  @doc """
  Returns the list of courses.

  ## Examples

      iex> list_courses()
      [%Campu{}, ...]

  """
  def list_courses do
    Repo.all(Course)
  end

  @doc """
  Returns the list of lists of courses, campus and universities.

  ## Examples

      iex> list_all_in_courses()
      [[course: %Course{}, campus: %Campu{}, university: %University{}], ...]

  """
  def list_all_in_courses(discretion) when is_list(discretion) do
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
        select: [course: cs, campus: c, university: u]

    Enum.reduce(discretion, query, fn
      {:kind, ""}, query ->
        query

      {:kind, kind}, query ->
        from q in query, where: like(q.kind, ^kind)

      {:level, ""}, query ->
        query

      {:level, level}, query ->
        from q in query, where: like(q.level, ^level)

      {:university, ""}, query ->
        query

      {:university, university}, query ->
        from q in query, where: like(q.university, ^university)

      {:shift, ""}, query ->
        query

      {:shift, shift}, query ->
        from q in query, where: like(q.shift, ^shift)
        #   from q in query, where: q.kind == ^kind

        # {:kind, kind, :level, level, :university, "", :shift, ""}, query ->
        #    from q in query, where: q.kind == ^kind and q.level == ^level

        # {:prices, [""]}, query ->
        #   query

        # {:prices, prices}, query ->
        #   from q in query, where: q.price in ^prices
    end)
    |> Repo.all()
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
