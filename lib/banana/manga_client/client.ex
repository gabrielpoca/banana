defmodule MangaClient.Client do
  alias MangaClient.Cache

  def all do
    key = "manga"
    request(key, fn () -> api().all() end)
  end

  def get(manga_id) do
    key = "manga_#{manga_id}"
    request(key, fn () -> api().manga(manga_id) end)
  end

  def chapter(manga, id) do
    key = "manga_chapter_#{manga}_#{id}"
    request(key, fn () -> api().manga_chapter(manga, id) end)
  end

  def search(query) do
    key = "manga_search_#{query}"
    request(key, fn () -> api().search(query) end)
  end

  defp request(key, fun) do
    case Cache.get(key) do
      {:found, response} -> {:ok, response}
      _ -> cache_response(key, fun.())
    end
  end

  defp cache_response(key, response) do
    case response do
      {:ok, body} ->
        Cache.set(key, body)
        {:ok, body}
      {:error} -> {:error}
    end
  end

  defp api do
    Application.get_env(:banana, MangaClient.Client)[:api]
  end
end
