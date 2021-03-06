defmodule QueroApiWeb.AuthAccessPipeline do
  @moduledoc """
  pipeline module assembles the plugs for a specific authentication scheme
  """
  use Guardian.Plug.Pipeline, otp_app: :quero_api

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
