defmodule Manga.ClientTest do
  use ExUnit.Case, async: true

  alias Manga.Cache
  alias Manga.Client

  setup do
    Supervisor.terminate_child(Banana.Supervisor, Manga.Supervisor)
    Supervisor.restart_child(Banana.Supervisor, Manga.Supervisor)
    :ok
  end

  describe "all" do
    test "it returns a cached response" do
      cached_response = "cached response"
      Cache.set("manga", cached_response)

      {:ok, mangas} = Client.all

      assert mangas == cached_response
    end
  end
end
