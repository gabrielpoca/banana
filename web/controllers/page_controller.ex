defmodule Banana.PageController do
  use Banana.Web, :authenticated_controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
