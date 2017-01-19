defmodule Banana.SessionControllerTest do
  use Banana.ConnCase

  alias Banana.User

  test "creates a user", %{conn: conn} do
    params = %{user: %{username: "naruto", password: "somepass"}}

    conn = post conn, session_path(conn, :create), params

    assert redirected_to(conn, 302) =~ manga_path(conn, :index)
    assert Repo.get_by(User, %{username: "naruto"})
  end

  test "signs in an existing user", %{conn: conn} do
    username = "naruto"
    password = "somepass"
    params = %{username: username, password: password}
    changeset = User.changeset(%User{}, params)
    Repo.insert(changeset)

    conn = post conn, session_path(conn, :create), %{user: params}

    assert Repo.one(from u in User, select: count("*")) == 1
    assert redirected_to(conn, 302) =~ manga_path(conn, :index)
  end
end
