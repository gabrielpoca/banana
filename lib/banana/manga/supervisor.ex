defmodule Manga.Supervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    children = [
      worker(Manga.Cache, [[name: Manga.Cache]]),
      worker(Manga.CacheInvalidator, [])
    ]

    supervise(children, strategy: :one_for_one)
  end
end
