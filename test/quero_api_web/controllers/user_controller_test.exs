defmodule QueroApiWeb.UserControllerTest do
  use QueroApiWeb.ConnCase, async: true

  import QueroApi.FixturesAll

  alias Argon2

  # alias QueroApi.Accounts
  # alias QueroApi.Accounts.User

  @create_attrs %{email: "teste2@email.com", password: "123456", password_confirmation: "123456"}
  @update_attrs %{email: "henry2@email.com", password: "123456", password_confirmation: "123456"}
  @invalid_attrs %{email: nil, password: nil, password_confirmation: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all users", %{conn: conn} do
      user =
        user_fixture(%{
          email: "test@email.com",
          password: "123789",
          password_confirmation: "123789"
        })

      conn = get(conn, Routes.user_path(conn, :index))

      assert json_response(conn, 200)["data"] == [
               %{
                 "id" => user.id,
                 "email" => "test@email.com",
                 "password_hash" => user.password_hash
               }
             ]
    end
  end

  describe "create user" do
    test "renders user when data is valid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.user_path(conn, :show, id))

      assert %{
               "id" => _id,
               "email" => "teste2@email.com",
               "password_hash" => _password_hash
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update user" do
    test "renders user when data is valid", %{conn: conn} do
      user = user_fixture(%{email: "henry@email.com"})
      conn = put(conn, Routes.user_path(conn, :update, user), @update_attrs)
      assert %{"id" => id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.user_path(conn, :show, id))

      assert %{
               "id" => _id,
               "email" => "henry2@email.com",
               "password_hash" => _password_hash
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      user = user_fixture()
      conn = put(conn, Routes.user_path(conn, :update, user), @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  # describe "delete user" do
  #   setup [:create_user]

  #   test "deletes chosen user", %{conn: conn, user: user} do
  #     conn = delete(conn, Routes.user_path(conn, :delete, user))
  #     assert response(conn, 204)

  #     assert_error_sent 404, fn ->
  #       get(conn, Routes.user_path(conn, :show, user))
  #     end
  #   end
  # end
end
