defmodule Banana.MangaControllerTest do
  use Banana.ConnCase

  import Banana.Factory

  test "redirects when not logged in", %{conn: conn} do
    conn = get conn, manga_path(conn, :index)

    assert redirected_to(conn) =~ session_path(conn, :new)
  end

  test "list all the mangas" do
    conn = guardian_login(insert(:user))
    {:ok, mangas} = MangaClient.Client.all

    conn = get conn, manga_path(conn, :index)

    assert html_response(conn, 200) =~ "Manga"
    for manga <- Enum.take(mangas, 10) do
      assert html_response(conn, 200) =~ manga["name"]
    end
  end

  test "show one manga" do
    conn = guardian_login(insert(:user))
    {:ok, manga} = MangaClient.Client.manga("naruto")

    conn = get conn, manga_path(conn, :show, manga["href"])

    assert html_response(conn, 200) =~ manga["name"]
    for chapter <- manga["chapters"] do
      assert html_response(conn, 200) =~ chapter["name"]
    end
  end
end
