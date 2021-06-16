# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :devspot,
  ecto_repos: [Devspot.Repo],
  generators: [binary_id: true]

config :devspot, Devspot.Repo,
  migration_primary_key: [type: :binary_id],
  migration_foreign_key: [type: :binary_id]

# Configures the endpoint
config :devspot, DevspotWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "DbEgADmIp/YvCfbVJ+dg0KjevCS8vSm40jpAK+vYrFM8OAgAtNknX84LEGezvgBA",
  render_errors: [view: DevspotWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Devspot.PubSub,
  live_view: [signing_salt: "CHLRXhCN"]

config :devspot, DevspotWeb.Auth.Guardian,
  issuer: "devspot",
  secret_key: "sN3kc9uhi+quB15Zbb1blddtxyTpg8QMWmjogPVC832EwffuzW3UhzpHGciSSb5g"

config :devspot, DevspotWeb.Auth.Pipeline,
  module: DevspotWeb.Auth.Guardian,
  error_handler: DevspotWeb.Auth.ErrorHandler

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
