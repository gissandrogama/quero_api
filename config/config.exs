# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :quero_api,
  ecto_repos: [QueroApi.Repo]

# Configures the endpoint
config :quero_api, QueroApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "VVoqfkUxkYP1+Ju7JPLt120bbroOo1UZDrqqvqyB19Yp0WHK0DUVB7+AA5r6UnBU",
  render_errors: [view: QueroApiWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: QueroApi.PubSub,
  live_view: [signing_salt: "a1ZtLCOH"]

# Configures Guardian
config :quero_api, QueroApiWeb.Guardian,
  issuer: "quero_api",
  secret_key: "4b+RGGjOyPymf/j952KvTP7nrkArCKZfj1F7LOtshnbSXKKbHoDW6C3GWPzx9PPH"

config :quero_api, QueroApiWeb.AuthAccessPipeline,
  module: QueroApiWeb.Guardian,
  error_handler: QueroApiWeb.AuthErrorHandler

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
