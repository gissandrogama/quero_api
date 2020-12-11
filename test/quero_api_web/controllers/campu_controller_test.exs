defmodule QueroApiWeb.CampuControllerTest do
  use QueroApiWeb.ConnCase

  # alias QueroApi.Campus
  # alias QueroApi.Campus.Campu

  # @create_attrs %{
  #   city: "some city",
  #   name: "some name"
  # }
  # @update_attrs %{
  #   city: "some updated city",
  #   name: "some updated name"
  # }
  # @invalid_attrs %{city: nil, name: nil}

  # def fixture(:campu) do
  #   {:ok, campu} = Campus.create_campu(@create_attrs)
  #   campu
  # end

  # setup %{conn: conn} do
  #   {:ok, conn: put_req_header(conn, "accept", "application/json")}
  # end

  # describe "index" do
  #   test "lists all campus", %{conn: conn} do
  #     conn = get(conn, Routes.campu_path(conn, :index))
  #     assert json_response(conn, 200)["data"] == []
  #   end
  # end

  # describe "create campu" do
  #   test "renders campu when data is valid", %{conn: conn} do
  #     conn = post(conn, Routes.campu_path(conn, :create), campu: @create_attrs)
  #     assert %{"id" => id} = json_response(conn, 201)["data"]

  #     conn = get(conn, Routes.campu_path(conn, :show, id))

  #     assert %{
  #              "id" => id,
  #              "city" => "some city",
  #              "name" => "some name"
  #            } = json_response(conn, 200)["data"]
  #   end

  #   test "renders errors when data is invalid", %{conn: conn} do
  #     conn = post(conn, Routes.campu_path(conn, :create), campu: @invalid_attrs)
  #     assert json_response(conn, 422)["errors"] != %{}
  #   end
  # end

  # describe "update campu" do
  #   setup [:create_campu]

  #   test "renders campu when data is valid", %{conn: conn, campu: %Campu{id: id} = campu} do
  #     conn = put(conn, Routes.campu_path(conn, :update, campu), campu: @update_attrs)
  #     assert %{"id" => ^id} = json_response(conn, 200)["data"]

  #     conn = get(conn, Routes.campu_path(conn, :show, id))

  #     assert %{
  #              "id" => id,
  #              "city" => "some updated city",
  #              "name" => "some updated name"
  #            } = json_response(conn, 200)["data"]
  #   end

  #   test "renders errors when data is invalid", %{conn: conn, campu: campu} do
  #     conn = put(conn, Routes.campu_path(conn, :update, campu), campu: @invalid_attrs)
  #     assert json_response(conn, 422)["errors"] != %{}
  #   end
  # end

  # describe "delete campu" do
  #   setup [:create_campu]

  #   test "deletes chosen campu", %{conn: conn, campu: campu} do
  #     conn = delete(conn, Routes.campu_path(conn, :delete, campu))
  #     assert response(conn, 204)

  #     assert_error_sent 404, fn ->
  #       get(conn, Routes.campu_path(conn, :show, campu))
  #     end
  #   end
  # end

  # defp create_campu(_) do
  #   campu = fixture(:campu)
  #   %{campu: campu}
  # end
end
