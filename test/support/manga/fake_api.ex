defmodule Manga.FakeAPI do
  import Manga.Constants

  def all do
    json = File.read!("test/support/manga/all.json") |> Poison.decode!
    {:ok, json}
  end

  def manga(_manga_id) do
    json = File.read!("test/support/manga/manga.json") |> Poison.decode!
    {:ok, json}
  end

  def manga_chapter(_manga_id, _chapter_id) do
    json = File.read!("test/support/manga/chapter.json") |> Poison.decode!
    {:ok, json}
  end

  def search(_query) do
    all()
  end
end
