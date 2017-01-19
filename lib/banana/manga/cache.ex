defmodule Manga.Cache do
  use GenServer

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :manga_cache_table, opts)
  end

  def get(url) do
    case GenServer.call(__MODULE__, {:get, url}) do
      [] -> {:not_found}
      [{_url, result}] -> {:found, result}
    end
  end

  def set(url, value) do
    GenServer.cast(__MODULE__, {:set, url, value})
  end

  def reset do
    GenServer.call(__MODULE__, {:reset})
  end

  def handle_call({:reset}, _from, state) do
    %{ets_table_name: ets_table_name} = state
    result = :ets.delete_all_objects(ets_table_name)
    {:reply, result, state}
  end

  def handle_call({:get, url}, _from, state) do
    %{ets_table_name: ets_table_name} = state
    result = :ets.lookup(ets_table_name, url)
    {:reply, result, state}
  end

  def handle_cast({:set, url, value}, state) do
    %{ets_table_name: ets_table_name} = state
    true = :ets.insert(ets_table_name, {url, value})
    {:noreply, state}
  end

  def init(ets_table_name) do
    :ets.new(ets_table_name, [:named_table, :set, :private])

    {:ok, %{ets_table_name: ets_table_name}}
  end
end
