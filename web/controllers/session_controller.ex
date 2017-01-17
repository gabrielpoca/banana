defmodule Banana.SessionController do
  use Banana.Web, :controller

  alias Banana.User
  alias Banana.Repo

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"user" => %{"username" => username, "password" => password}} = params) do
    user = Repo.get_by(User, username: username)

    case User.check_password(password, user) do
      true ->
        conn
        |> Guardian.Plug.sign_in(user)
        |> redirect(to: manga_path(conn, :index))
      false ->
        render conn, "new.html", changeset: User.changeset(%User{})
    end
  end

  def delete(conn, _params) do
    Guardian.Plug.sign_out(conn)
    |> redirect(to: session_path(conn, :new))
  end
end
