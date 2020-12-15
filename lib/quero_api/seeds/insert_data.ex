defmodule QueroApi.Seeds.InsertData do
  @moduledoc """
  Este modulo possui funções que automatizão a inserção de dados apartir de um arquivo json e
  mapeia das associações de relações do banco de dados.
  """
  alias QueroApi.Seeds.{
    InsertCampus,
    InsertCampusCourses,
    InsertCourses,
    InsertCoursesOffers,
    InsertOffers,
    InsertUnivesity
  }

  @spec insert_data(String) :: [map()]
  def insert_data(name) do
    InsertCourses.insert_courses()
    InsertOffers.insert_offers()

    Enum.filter(db_json(), fn universities -> universities["university"]["name"] == name end)
    |> InsertUnivesity.insert_university()
    |> InsertCampus.insert_campus(name)
    |> InsertCampusCourses.insert_campus_courses(name)
    |> InsertCoursesOffers.insert_courses_offers(name)
  end

  @doc """
  função que ler o arquivo json
  """
  @spec db_json :: [map()]
  def db_json do
    File.read!("./priv/repo/db.json") |> Jason.decode!()
  end
end
