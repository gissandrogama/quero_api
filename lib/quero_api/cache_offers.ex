defmodule QueroApi.CacheOffers do
  @moduledoc """
  Cache offers
  """
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, %{}, name: OfferCache)
  end

  def init(state) do
    :ets.new(:offer_course, [:set, :public, :named_table])
    {:ok, state}
  end

  def insert(data) do
    GenServer.call(OfferCache, {:insert, data})
  end

  def get do
    GenServer.call(OfferCache, {:get, :offers})
  end

  def delete(key) do
    GenServer.cast(OfferCache, {:delete, key})
  end

  # Internal API
  def handle_call({:insert, data}, _from, state) do
    :ets.insert(:offer_course, {:offers, data})
    {:reply, :ok, state}
  end

  def handle_call({:get, :offers}, _from, state) do
    data =
      case :ets.lookup(:offer_course, :offers) do
        [] -> []
        [{:offers, offers}] -> offers
      end

    {:reply, data, state}
  end

  def handle_cast({:delete, key}, state) do
    :ets.delete(:offer_course, key)
    {:noreply, state}
  end
end
