defmodule QueroApi.Seeds.InsertCourses do
  @moduledoc """
  Esse modulo possui funçãos que inserem cursos na tabela courses.
  """
  alias QueroApi.Seeds.InsertData

  @spec insert_courses :: [map()]
  def insert_courses do
    Enum.filter(InsertData.db_json(), fn offers -> offers["course"] end)
    |> Enum.map(fn courses -> courses["course"] end)
    |> Enum.uniq()
    |> Enum.map(fn course -> QueroApi.Courses.create_course(course) end)
  end
end
