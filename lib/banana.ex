defmodule Banana do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = [
      # Start the Ecto repository
      supervisor(Banana.Repo, []),
      # Start the endpoint when the application starts
      supervisor(Banana.Endpoint, []),
      # Start your own worker by calling: Banana.Worker.start_link(arg1, arg2, arg3)
      # worker(Banana.Worker, [arg1, arg2, arg3]),
      supervisor(Manga.Supervisor, []),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Banana.Supervisor]
    start_result = Supervisor.start_link(children, opts)

    Ecto.Migrator.run(Banana.Repo, "priv/repo/migrations", :up, all: true)

    start_result
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    Banana.Endpoint.config_change(changed, removed)
    :ok
  end
end
