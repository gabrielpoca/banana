defmodule Banana.ChapterControllerTest do
  use Banana.ConnCase

  import Banana.Factory

  setup do
    conn = guardian_login(insert(:user))
    {:ok, conn: conn}
  end

  test "show one chapter", %{conn: conn} do
    {:ok, chapter} = MangaClient.Client.chapter("naruto", 1)

    conn = get conn, manga_chapter_path(conn, :show, "naruto", 1)

    assert html_response(conn, 200) =~ chapter["name"]
    for chapter <- chapter["pages"] do
      assert html_response(conn, 200) =~ chapter["url"]
    end
  end
end
