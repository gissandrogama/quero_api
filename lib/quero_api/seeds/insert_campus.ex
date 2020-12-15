defmodule QueroApi.Seeds.InsertCampus do
  @moduledoc """
  Esse modulo possui funçãos que inserem universidades na tabela univesity.
  """
  alias QueroApi.Seeds.InsertData

  def insert_campus(university, name) do
    {:ok, university} = university

    Enum.filter(InsertData.db_json(), fn universities ->
      universities["university"]["name"] == name
    end)
    |> Enum.map(fn univer -> univer["campus"] end)
    |> Enum.map(fn campu -> %{city: campu["city"], name: campu["name"]} end)
    |> Enum.uniq_by(fn campu -> campu.name end)
    |> Enum.map(fn campu -> Ecto.build_assoc(university, :campus, campu) end)
    |> Enum.map(fn campu -> QueroApi.Repo.insert!(campu) end)
  end
end
