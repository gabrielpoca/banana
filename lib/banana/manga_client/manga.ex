defmodule MangaClient.Manga do
  def last_chapter(manga) do
    manga
    |> Map.get("chapters")
    |> List.first
    |> Map.get("chapterId")
  end
end
