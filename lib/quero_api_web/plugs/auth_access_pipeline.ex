defmodule QueroApiWeb.AuthAccessPipeline do
  use Guardian.Plug.Pipeline, otp_app: :quero_api

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
