defmodule QueroApiWeb.OfferControllerTest do
  use QueroApiWeb.ConnCase

  alias QueroApi.Offers
  alias QueroApi.Offers.Offer

  @create_attrs %{
    discount_percentage: 120.5,
    enabled: true,
    enrollment_semester: "some enrollment_semester",
    full_price: 120.5,
    price_with_discount: 120.5,
    start_date: "some start_date"
  }
  @update_attrs %{
    discount_percentage: 456.7,
    enabled: false,
    enrollment_semester: "some updated enrollment_semester",
    full_price: 456.7,
    price_with_discount: 456.7,
    start_date: "some updated start_date"
  }
  @invalid_attrs %{discount_percentage: nil, enabled: nil, enrollment_semester: nil, full_price: nil, price_with_discount: nil, start_date: nil}

  def fixture(:offer) do
    {:ok, offer} = Offers.create_offer(@create_attrs)
    offer
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all offers", %{conn: conn} do
      conn = get(conn, Routes.offer_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create offer" do
    test "renders offer when data is valid", %{conn: conn} do
      conn = post(conn, Routes.offer_path(conn, :create), offer: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.offer_path(conn, :show, id))

      assert %{
               "id" => id,
               "discount_percentage" => 120.5,
               "enabled" => true,
               "enrollment_semester" => "some enrollment_semester",
               "full_price" => 120.5,
               "price_with_discount" => 120.5,
               "start_date" => "some start_date"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.offer_path(conn, :create), offer: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update offer" do
    setup [:create_offer]

    test "renders offer when data is valid", %{conn: conn, offer: %Offer{id: id} = offer} do
      conn = put(conn, Routes.offer_path(conn, :update, offer), offer: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.offer_path(conn, :show, id))

      assert %{
               "id" => id,
               "discount_percentage" => 456.7,
               "enabled" => false,
               "enrollment_semester" => "some updated enrollment_semester",
               "full_price" => 456.7,
               "price_with_discount" => 456.7,
               "start_date" => "some updated start_date"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, offer: offer} do
      conn = put(conn, Routes.offer_path(conn, :update, offer), offer: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete offer" do
    setup [:create_offer]

    test "deletes chosen offer", %{conn: conn, offer: offer} do
      conn = delete(conn, Routes.offer_path(conn, :delete, offer))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.offer_path(conn, :show, offer))
      end
    end
  end

  defp create_offer(_) do
    offer = fixture(:offer)
    %{offer: offer}
  end
end
