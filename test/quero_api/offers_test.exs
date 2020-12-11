defmodule QueroApi.OffersTest do
  use QueroApi.DataCase, async: true

  import QueroApi.FixturesAll

  alias QueroApi.Offers

  describe "offers" do
    alias QueroApi.Offers.Offer

    @valid_attrs %{
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
    @invalid_attrs %{
      discount_percentage: nil,
      enabled: nil,
      enrollment_semester: nil,
      full_price: nil,
      price_with_discount: nil,
      start_date: nil
    }

    test "list_offers/0 returns all offers" do
      offer = offers_fixture()
      assert Offers.list_offers() == [offer]
    end

    test "get_offer!/1 returns the offer with given id" do
      offer = offers_fixture()
      assert Offers.get_offer!(offer.id) == offer
    end

    test "create_offer/1 with valid data creates a offer" do
      assert {:ok, %Offer{} = offer} = Offers.create_offer(@valid_attrs)
      assert offer.discount_percentage == 120.5
      assert offer.enabled == true
      assert offer.enrollment_semester == "some enrollment_semester"
      assert offer.full_price == 120.5
      assert offer.price_with_discount == 120.5
      assert offer.start_date == "some start_date"
    end

    test "create_offer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Offers.create_offer(@invalid_attrs)
    end

    test "update_offer/2 with valid data updates the offer" do
      offer = offers_fixture()
      assert {:ok, %Offer{} = offer} = Offers.update_offer(offer, @update_attrs)
      assert offer.discount_percentage == 456.7
      assert offer.enabled == false
      assert offer.enrollment_semester == "some updated enrollment_semester"
      assert offer.full_price == 456.7
      assert offer.price_with_discount == 456.7
      assert offer.start_date == "some updated start_date"
    end

    test "update_offer/2 with invalid data returns error changeset" do
      offer = offers_fixture()
      assert {:error, %Ecto.Changeset{}} = Offers.update_offer(offer, @invalid_attrs)
      assert offer == Offers.get_offer!(offer.id)
    end

    test "delete_offer/1 deletes the offer" do
      offer = offers_fixture()
      assert {:ok, %Offer{}} = Offers.delete_offer(offer)
      assert_raise Ecto.NoResultsError, fn -> Offers.get_offer!(offer.id) end
    end

    test "change_offer/1 returns a offer changeset" do
      offer = offers_fixture()
      assert %Ecto.Changeset{} = Offers.change_offer(offer)
    end
  end
end
