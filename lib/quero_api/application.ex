defmodule QueroApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      QueroApi.Repo,
      # Start the Telemetry supervisor
      QueroApiWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: QueroApi.PubSub},
      # Start the Endpoint (http/https)
      QueroApiWeb.Endpoint,
      # Start a worker by calling: QueroApi.Worker.start_link(arg)
      # {QueroApi.Worker, arg}
      QueroApi.CacheCourses,
      QueroApi.CacheOffers
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: QueroApi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    QueroApiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
