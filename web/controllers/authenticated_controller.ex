defmodule Banana.AuthenticatedController do
  use Banana.Web, :controller

  def unauthenticated(conn, _params) do
    redirect(conn, to: session_path(conn, :new))
  end
end
