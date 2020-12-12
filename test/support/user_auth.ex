defmodule QueroApiWeb.UserAurh do
  @moduledoc """
  Authenticate request as user
  """

  import QueroApi.FixturesAll
  import Plug.Conn

  alias QueroApiWeb.Guardian

  def authenticate(conn, user \\ user_fixture()) do
    {:ok, token, _} = Guardian.encode_and_sign(user)

    put_req_header(conn, "authorization", "Bearer " <> token)
  end
end
