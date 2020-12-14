defmodule QueroApi.CacheCourses do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, %{}, name: CourseCache)
  end

  def init(state) do
    :ets.new(:course_cache, [:set, :public, :named_table])
    {:ok, state}
  end

  def insert(data) do
    GenServer.call(CourseCache, {:insert, data})
  end

  def get do
    GenServer.call(CourseCache, {:get, :courses})
  end

  def delete(key) do
    GenServer.cast(CourseCache, {:delete, key})
  end


  # Internal API
  def handle_call({:insert, data}, _from, state) do
    :ets.insert(:course_cache, {:courses, data})
    {:reply, :ok, state}
  end

  def handle_call({:get, :courses}, _from, state) do
    data =
      case :ets.lookup(:course_cache, :courses) do
        [] -> []
        [{:courses, courses}] -> courses
      end
      {:reply, data, state}
  end

  def handle_cast({:delete, key}, state) do
    :ets.delete(:course_cache, key)
    {:noreply, state}
  end
end
