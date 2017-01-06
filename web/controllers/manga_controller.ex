defmodule Banana.MangaController do
  use Banana.Web, :authenticated_controller

  alias Manga.Client
  alias Banana.{MangaLastChapter, Chapter}

  @manga_error "We cannot find this manga. Please try again or report to the administrator"

  def index(conn, params, current_user, _claims) do
    pagination_config = pagination(params)

    case get_mangas(params) do
      {:ok, mangas} ->
        page = Scrivener.paginate(mangas, pagination_config)
        render conn, "index.html",
          mangas: page.entries,
          mangas_chapter: last_read_chapter(current_user),
          page_number: page.page_number,
          page_size: page.page_size,
          total_pages: page.total_pages,
          total_entries: page.total_entries
      {:error} ->
        render(conn, "error.html", message: "")
    end
  end

  def show(conn, %{"id" => manga_id}, current_user, _claims) do
    case Client.get(manga_id) do
      {:ok, manga} ->
        render conn, "show.html",
          manga: manga,
          manga_id: manga_id,
          read_chapters: read_chapters(current_user, manga_id),
          last_read_chapter: last_read_chapter(current_user, manga_id)
      {:error} ->
        render(conn, "error.html", message: @manga_error)
    end
  end

  defp get_mangas(%{"manga" => %{"q" => query}} = _params), do: Client.search(query)
  defp get_mangas(_params), do: Client.all

  defp pagination(%{"page" => _page, "page_size" => _page_size} = params), do: params
  defp pagination(_params), do: %Scrivener.Config{page_number: 1, page_size: 20}

  defp read_chapters(current_user, manga_id) do
    from(c in Chapter,
      where: c.user_id == ^current_user.id and c.manga == ^manga_id)
    |> Repo.all
  end

  defp last_read_chapter(current_user, manga_id) do
    Repo.get_by(MangaLastChapter, %{user_id: current_user.id, manga: manga_id})
  end

  defp last_read_chapter(current_user) do
    from(c in MangaLastChapter, where: c.user_id == ^current_user.id)
    |> Repo.all
  end
end
