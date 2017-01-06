defmodule Manga.CacheInvalidator do
  use GenServer

  alias Manga.Cache

  def start_link do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    schedule_work()
    {:ok, state}
  end

  def handle_info(:work, state) do
    Cache.reset()
    schedule_work()
    {:noreply, state}
  end

  defp schedule_work do
    Process.send_after(self(), :work, 60 * 60 * 1000) # every hour
  end
end
