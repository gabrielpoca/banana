# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :banana,
  ecto_repos: [Banana.Repo]

# Configures the endpoint
config :banana, Banana.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "rxWJ+vr44inMvQVpoWDA88MBK2S+pniERwpcvDbIEH47blXgVv9XqOS5ulbGU2KG",
  render_errors: [view: Banana.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Banana.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :guardian, Guardian,
  issuer: "Banana",
  ttl: { 90, :days },
  secret_key: "eyJhbGciOiJIUzUxMiIsInR5cCI6",
  serializer: Banana.GuardianSerializer

config :banana, MangaClient.Client,
  api: MangaClient.API

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
