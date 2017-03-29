defmodule MangaClient.MangaTest do
  use ExUnit.Case, async: true

  alias MangaClient.Client
  alias MangaClient.Manga

  setup do
    Supervisor.terminate_child(Banana.Supervisor, MangaClient.Supervisor)
    Supervisor.restart_child(Banana.Supervisor, MangaClient.Supervisor)
    :ok
  end

  describe "last_chapter" do
    test "returns the last chapter" do
      {:ok, manga} = Client.get("naruto")

      assert Manga.last_chapter(manga) == 7
    end
  end
end
