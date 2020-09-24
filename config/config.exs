# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :latency,
  ecto_repos: [Latency.Repo]

# Configures the endpoint
config :latency, LatencyWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "iprRpLchu0JggmNP1R9eU7hxVj7hwK0+juH2DtFXF37sosQqP6l4vbg1hrJ6SIcJ",
  render_errors: [view: LatencyWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Latency.PubSub,
  live_view: [signing_salt: "O19Pi05q"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
