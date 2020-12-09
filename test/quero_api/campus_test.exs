defmodule QueroApi.CampusTest do
  use QueroApi.DataCase, async: true

  alias QueroApi.Campus

  describe "campus" do
    alias QueroApi.Campus.Campu

    @valid_attrs %{city: "some city", name: "some name"}
    @update_attrs %{city: "some updated city", name: "some updated name"}
    @invalid_attrs %{city: nil, name: nil}

    def campu_fixture(attrs \\ %{}) do
      {:ok, campu} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Campus.create_campu()

      campu
    end

    test "list_campus/0 returns all campus" do
      campu = campu_fixture()
      assert Campus.list_campus() == [campu]
    end

    test "get_campu!/1 returns the campu with given id" do
      campu = campu_fixture()
      assert Campus.get_campu!(campu.id) == campu
    end

    test "create_campu/1 with valid data creates a campu" do
      assert {:ok, %Campu{} = campu} = Campus.create_campu(@valid_attrs)
      assert campu.city == "some city"
      assert campu.name == "some name"
    end

    test "create_campu/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Campus.create_campu(@invalid_attrs)
    end

    test "update_campu/2 with valid data updates the campu" do
      campu = campu_fixture() |> QueroApi.Repo.preload(:courses)
      assert {:ok, %Campu{} = campu} = Campus.update_campu(campu, @update_attrs)
      assert campu.city == "some updated city"
      assert campu.name == "some updated name"
    end

    test "update_campu/2 with invalid data returns error changeset" do
      campu = campu_fixture() |> QueroApi.Repo.preload(:courses)
      assert {:error, %Ecto.Changeset{}}  = Campus.update_campu(campu, @invalid_attrs)
      assert campu == Campus.get_campu!(campu.id) |> QueroApi.Repo.preload(:courses)
    end

    test "delete_campu/1 deletes the campu" do
      campu = campu_fixture()
      assert {:ok, %Campu{}} = Campus.delete_campu(campu)
      assert_raise Ecto.NoResultsError, fn -> Campus.get_campu!(campu.id) end
    end

    test "change_campu/1 returns a campu changeset" do
      campu = campu_fixture() |> QueroApi.Repo.preload(:courses)
      assert %Ecto.Changeset{} = Campus.change_campu(campu)
    end
  end
end
