defmodule MangaClient.ClientTest do
  use ExUnit.Case, async: true

  alias MangaClient.Cache
  alias MangaClient.Client

  setup do
    Supervisor.terminate_child(Banana.Supervisor, MangaClient.Supervisor)
    Supervisor.restart_child(Banana.Supervisor, MangaClient.Supervisor)
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
