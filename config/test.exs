use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :banana, Banana.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :banana, Banana.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: System.get_env("DB_USERNAME") || System.get_env("DATABASE_POSTGRESQL_USERNAME") || "postgres",
  password: System.get_env("DATABASE_POSTGRESQL_PASSWORD") || "",
  database: "banana_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :banana, MangaClient.Client,
  api: MangaClient.FakeAPI
