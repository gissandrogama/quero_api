defmodule QueroApi.Seeds.InsertCampusCourses do
  @moduledoc """
  Esse modulo possui funçãos que inserem id de campus e courses na tabela campus_courses.
  """
  alias QueroApi.Seeds.InsertData

  def insert_campus_courses(campus, name) do
    Enum.filter(InsertData.db_json(), fn campu -> campu["university"]["name"] == name end)
    |> Enum.map(fn campu -> {campu["campus"], campu["course"]} end)
    |> assoc_campus_course(campus)
    |> Enum.map(fn courses -> QueroApi.Repo.update!(courses) end)
  end

  def assoc_campus_course(json_courses_campus, campus) do
    merger(json_courses_campus, campus)
    |> Enum.map(fn {campu, course} ->
      {QueroApi.Repo.preload(campu, [:university, :courses]), course}
    end)
    |> Enum.map(fn {campu, course} -> {QueroApi.Campus.change_campu(campu), course} end)
    |> Enum.map(fn {campu, course} -> Ecto.Changeset.put_assoc(campu, :courses, [course]) end)
  end

  defp merger(json, campus) do
    courses = QueroApi.Courses.list_courses()

    campus_courses =
      for {campu, course} <- json,
          campus_map <- campus,
          campu["name"] == campus_map.name,
          do: {campus_map, course}

    campus_courses =
      for {campu, course} <- campus_courses,
          courses_map <- courses,
          course["name"] == courses_map.name,
          course["kind"] == courses_map.kind,
          course["level"] == courses_map.level,
          course["shift"] == courses_map.shift,
          do: {campu, courses_map}

    campus_courses
  end
end
