defmodule QueroApiWeb.CoursesOfferControllerTest do
  use QueroApiWeb.ConnCase

  # alias QueroApi.CoursesOffers
  # alias QueroApi.CoursesOffers.CoursesOffer

  # @create_attrs %{

  # }
  # @update_attrs %{

  # }
  # @invalid_attrs %{}

  # def fixture(:courses_offer) do
  #   {:ok, courses_offer} = CoursesOffers.create_courses_offer(@create_attrs)
  #   courses_offer
  # end

  # setup %{conn: conn} do
  #   {:ok, conn: put_req_header(conn, "accept", "application/json")}
  # end

  # describe "index" do
  #   test "lists all courses_offers", %{conn: conn} do
  #     conn = get(conn, Routes.courses_offer_path(conn, :index))
  #     assert json_response(conn, 200)["data"] == []
  #   end
  # end

  # describe "create courses_offer" do
  #   test "renders courses_offer when data is valid", %{conn: conn} do
  #     conn = post(conn, Routes.courses_offer_path(conn, :create), courses_offer: @create_attrs)
  #     assert %{"id" => id} = json_response(conn, 201)["data"]

  #     conn = get(conn, Routes.courses_offer_path(conn, :show, id))

  #     assert %{
  #              "id" => id
  #            } = json_response(conn, 200)["data"]
  #   end

  #   test "renders errors when data is invalid", %{conn: conn} do
  #     conn = post(conn, Routes.courses_offer_path(conn, :create), courses_offer: @invalid_attrs)
  #     assert json_response(conn, 422)["errors"] != %{}
  #   end
  # end

  # describe "update courses_offer" do
  #   setup [:create_courses_offer]

  #   test "renders courses_offer when data is valid", %{conn: conn, courses_offer: %CoursesOffer{id: id} = courses_offer} do
  #     conn = put(conn, Routes.courses_offer_path(conn, :update, courses_offer), courses_offer: @update_attrs)
  #     assert %{"id" => ^id} = json_response(conn, 200)["data"]

  #     conn = get(conn, Routes.courses_offer_path(conn, :show, id))

  #     assert %{
  #              "id" => id
  #            } = json_response(conn, 200)["data"]
  #   end

  #   test "renders errors when data is invalid", %{conn: conn, courses_offer: courses_offer} do
  #     conn = put(conn, Routes.courses_offer_path(conn, :update, courses_offer), courses_offer: @invalid_attrs)
  #     assert json_response(conn, 422)["errors"] != %{}
  #   end
  # end

  # describe "delete courses_offer" do
  #   setup [:create_courses_offer]

  #   test "deletes chosen courses_offer", %{conn: conn, courses_offer: courses_offer} do
  #     conn = delete(conn, Routes.courses_offer_path(conn, :delete, courses_offer))
  #     assert response(conn, 204)

  #     assert_error_sent 404, fn ->
  #       get(conn, Routes.courses_offer_path(conn, :show, courses_offer))
  #     end
  #   end
  # end

  # defp create_courses_offer(_) do
  #   courses_offer = fixture(:courses_offer)
  #   %{courses_offer: courses_offer}
  # end
end
