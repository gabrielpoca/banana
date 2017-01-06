defmodule Manga.Manga do
  def last_chapter(manga) do
    a = manga
    |> Map.get("chapters")
    |> List.first
    |> Map.get("chapterId")
  end
end
