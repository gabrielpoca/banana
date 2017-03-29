defmodule Banana.ChapterController do
  use Banana.Web, :authenticated_controller

  alias Banana.TrackChapter
  alias MangaClient.{Client, Manga}

  @chapter_error "We cannot find this chapter. Please try again or report to the administrator"

  def show(conn, %{"manga_id" => manga_id, "id" => chapter_id}, current_user, _claims) do
    with {:ok, manga} <- Client.manga(manga_id),
         last_chapter <- Manga.last_chapter(manga),
         {:ok, chapter} <- Client.chapter(manga_id, chapter_id),
         {:ok} <- TrackChapter.call(manga_id, chapter_id, current_user.id) do

      conn
      |> assign(:app_modifier, "App--dark")
      |> render("show.html",
        chapter: chapter,
        chapter_id: Integer.parse(chapter_id) |> elem(0),
        last_chapter_id: last_chapter,
        manga_id: manga_id)
    else
      _ -> render(conn, "error.html", message: @chapter_error)
    end
  end
end
