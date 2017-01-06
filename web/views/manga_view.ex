defmodule Banana.MangaView do
  use Banana.Web, :view

  @page_offset 2

  alias Banana.Chapter

  def previous_page(conn, page_number, page_size, total_pages) do
    if page_number > 1 do
      link "Previous Page", to: manga_path(conn, :index, page: page_number - 1, page_size: page_size), class: "Button"
    else
      content_tag(:div, "")
    end
  end

  def next_page(conn, page_number, page_size, total_pages) do
    if page_number < total_pages do
      link "Next Page", to: manga_path(conn, :index, page: page_number + 1, page_size: page_size), class: "Button"
    else
      content_tag(:div, "")
    end
  end

  def chapter_for_manga(chapters, manga) do
    with %{chapter: chapter} <- find_chapter_for_manga(chapters, manga) do
      "Reading on chapter #{chapter}"
    else
      _ -> ""
    end
  end

  def read_chapter(read_chapters, chapter) do
    Enum.find(read_chapters, fn (c) -> c.chapter == chapter["chapterId"] end)
    |> is_map
  end

  def chapter_name(chapter) do
    case chapter["name"] do
      "" -> "Chapter #{chapter["chapterId"]}"
      name -> "Chapter #{chapter["chapterId"]}: #{name}"
    end
  end

  defp find_chapter_for_manga(chapters, manga) do
    Enum.find(chapters, fn (c) -> c.manga == manga end)
  end
end
