defmodule Manga.MangaTest do
  use ExUnit.Case, async: true

  alias Manga.Client
  alias Manga.Manga

  describe "last_chapter" do
    test "returns the last chapter" do
      {:ok, manga} = Client.get("naruto")

      assert Manga.last_chapter(manga) == 7
    end
  end
end
