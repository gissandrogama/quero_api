defmodule QueroApiWeb.UserViewTest do
  use ExUnit.Case, async: true

  alias QueroApiWeb.UserView

  test "render/2 returns index user" do
    users = [%{id: "1", email: "teste@email.com", password_hash: "123456"}]
    assert %{data: [%{id: "1", email: "teste@email.com", password_hash: "123456"}]} =
             UserView.render("index.json", %{users: users})
  end

  test "render/2 returns show user" do
    user = %{id: "1", email: "teste@email.com", password_hash: "123456"}
    assert %{data: %{id: "1", email: "teste@email.com", password_hash: "123456"}} =
             UserView.render("show.json", %{user: user})
  end

  test "render/2 returns session user" do

    assert %{status: "ok",  data: %{email: "teste@email.com", token: "token123"}} =
             UserView.render("session.json", %{user: %{email: "teste@email.com"}, token: "token123"})
  end
end
