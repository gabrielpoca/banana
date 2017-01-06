defmodule Banana.Router do
  use Banana.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :browser_auth do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
  end

  scope "/", Banana do
    pipe_through :browser
    resources "/users", UserController
    resources "/session", SessionController, only: [:new, :create], singleton: true
  end

  scope "/", Banana do
    pipe_through [:browser, :browser_auth]

    resources "/session", SessionController, only: [:delete], singleton: true
    resources "/mangas", MangaController, only: [:index, :show] do
      resources "/chapters", ChapterController, only: [:show]
    end

    get "/", MangaController, :index
  end
end
