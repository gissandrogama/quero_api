defmodule QueroApi.Seeds.InsertOffers do
  @moduledoc """
  Esse modulo possui funçãos que inserem offers na tabela offers.
  """
  alias QueroApi.Seeds.InsertData

  @spec insert_offers :: [map()]
  def insert_offers do
    Enum.filter(InsertData.db_json(), fn offers ->
      %{
        "full_price" => offers["full_price"],
        "price_with_discount" => offers["price_with_discount"],
        "discount_percentage" => offers["discount_percentage"],
        "start_date" => offers["start_date"],
        "enrollment_semester" => offers["enrollment_semester"],
        "enabled" => offers["enabled"]
      }
    end)
    |> Enum.uniq()
    |> Enum.map(fn offer -> QueroApi.Offers.create_offer(offer) end)
  end
end
