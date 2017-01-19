defmodule Banana.SessionController do
  use Banana.Web, :controller

  alias Banana.User
  alias Banana.Repo

  def new(conn, _params) do
    changeset = User.changeset(%User{})

    conn
    |> assign(:app_modifier, "App--dark")
    |> assign(:hide_nav, true)
    |> render "new.html", changeset: changeset
  end

  def create(conn, %{"user" => %{"username" => username, "password" => password}} = params) do
    case find_or_create_user(username, password) do
      {:ok, user} ->
        conn
        |> Guardian.Plug.sign_in(user)
        |> redirect(to: manga_path(conn, :index))
      _ ->
        render conn, "new.html", changeset: User.changeset(%User{})
    end
  end

  def delete(conn, _params) do
    Guardian.Plug.sign_out(conn)
    |> redirect(to: session_path(conn, :new))
  end

  defp find_or_create_user(username, password) do
    with user <- Repo.get_by(User, username: username),
         true <- User.check_password(password, user) do
         {:ok, user}
    else
      _ ->
        changeset = User.changeset(%User{}, %{username: username, password: password})
        Repo.insert(changeset)
    end
  end
end
