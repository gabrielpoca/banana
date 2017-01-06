defmodule Banana.ChapterView do
  use Banana.Web, :view

  def not_deferred_pages(chapter) do
    Enum.take(chapter["pages"], 3)
  end

  def deferred_pages(chapter) do
    Enum.drop(chapter["pages"], 3)
  end

  def previous_chapter(conn, chapter, last_chapter, manga) when chapter > 1 do
    link "Previous",
      to: manga_chapter_path(conn, :show, manga, (chapter - 1)),
      class: "Link Link--backward"
  end

  def previous_chapter(_conn, _chapter, _last_chapter, _manga), do: content_tag(:span, "")

  def next_chapter(conn, chapter, last_chapter, manga) when chapter < last_chapter do
    link "Next",
      to: manga_chapter_path(conn, :show, manga, (chapter + 1)),
      class: "Link Link--forward"
  end

  def next_chapter(_conn, _chapter, _last_chapter, _manga), do: content_tag(:span, "")
end
