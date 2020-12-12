defmodule QueroApiWeb.UserController do
  use QueroApiWeb, :controller

  alias QueroApi.Accounts
  alias QueroApi.Accounts.User
  alias QueroApiWeb.Guardian

  action_fallback QueroApiWeb.FallbackController

  def sign_in(conn, %{"email" => email, "password" => password}) do
    case Accounts.authenticate_user(email, password) do
      {:ok, user} ->
        {:ok, token, _claims} = Guardian.encode_and_sign(user)
        render(conn, "session.json", %{user: user, token: token})

      {:error, _} ->
        conn
        |> put_status(401)
        |> json(%{status: "unautheticated"})
    end
  end

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"email" => email, "password" => password, "password_confirmation" => password_confirmation}) do
    with {:ok, %User{} = user} <- Accounts.create_user(%{email: email, password: password, password_confirmation: password_confirmation}) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "email" => email, "password" => password, "password_confirmation" => password_confirmation}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{} = user} <- Accounts.update_user(user, %{email: email, password: password, password_confirmation: password_confirmation}) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{}} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
