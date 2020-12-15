defmodule QueroApi.Seeds.InsertUnivesity do
  @moduledoc """
  Esse modulo possui funçãos que inserem universidades na tabela univesity.
  """

  def insert_university(data) do
    data
    |> Enum.map(fn univer -> univer["university"] end)
    |> List.first()
    |> QueroApi.Universities.create_university()
  end
end
