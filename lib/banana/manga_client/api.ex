defmodule MangaClient.API do
  import MangaClient.Constants

  def all do
    get(all_url())
  end

  def manga(manga_id) do
    case get(manga_url(manga_id)) do
      {:ok, body} ->
        chapters = List.foldl(body["chapters"], [], fn (c, acc) -> [c] ++ acc end)
        {:ok, %{body | "chapters" => chapters}}
      {:error} -> {:error}
    end
  end

  def chapter(manga_id, chapter_id) do
    get(manga_chapter_url(manga_id, chapter_id))
  end

  def search(query) do
    query = URI.encode(query)
    case get(search_url(query)) do
      {:ok, mangas} ->
        if is_list(mangas) do
          {:ok, mangas}
        else
          {:ok, []}
        end
      _ -> {:ok, []}
    end
  end

  defp get(url) do
    case HTTPoison.get(url, headers()) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        parse_body(body)
      {:error, _} ->
        {:error}
    end
  end

  defp parse_body(body) when body == "{}", do: {:error}

  defp parse_body(body) do
    case Poison.decode!(body) do
      %{"error" => _} -> {:error}
      body -> {:ok, body}
    end
  end

  defp headers do
    ["X-Mashape-Key": Application.get_env(:banana, MangaClient.Client)[:key]]
  end
end
