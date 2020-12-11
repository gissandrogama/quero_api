defmodule QueroApi.AccountsTest do
  use QueroApi.DataCase, async: true

  import QueroApi.FixturesAll

  alias QueroApi.Accounts

  describe "users" do
    alias QueroApi.Accounts.User

    @valid_attrs %{
      email: "someemail@email.com",
      password: "some password",
      password_confirmation: "some password"
    }
    @update_attrs %{
      email: "someemailupdate@email.com",
      password: "some password update",
      password_confirmation: "some password update"
    }
    @invalid_attrs %{email: nil, password_hash: nil}

    test "list_users/0 returns all users" do
      user = user_fixture()

      user_get =
        Accounts.list_users() |> Enum.map(fn users -> {users.email, users.password_hash} end)

      assert user_get == [{user.email, user.password_hash}]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      user_get = Accounts.get_user!(user.id)
      assert user_get.email == user.email
      assert user_get.password_hash == user.password_hash
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.email == "someemail@email.com"
      assert user.password == "some password"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Accounts.update_user(user, @update_attrs)
      assert user.email == "someemailupdate@email.com"
      assert user.password == "some password update"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      user_get = Accounts.get_user!(user.id)
      assert user_get.email == user.email
      assert user_get.password_hash == user.password_hash
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end

    test "authenticate_user/2 returns ok when email and password match" do
      user_fixture(%{email: "henry@henry.com"})
      assert {:ok, %User{}} = Accounts.authenticate_user("henry@henry.com", "123456")
    end

    test "authenticate_user/2 returns error when there is no user with this email" do
      user_fixture(%{email: "henry@henry.com"})
      assert {:error, :invalid_credentials} = Accounts.authenticate_user("henry2@henry.com", "123456")
    end

    test "authenticate_user/2 returns error when the password is invalid" do
      user_fixture(%{email: "henry@henry.com"})
      assert {:error, :invalid_credentials} = Accounts.authenticate_user("henry@henry.com", "1234568")
    end
  end


end
