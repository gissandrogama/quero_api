defmodule QueroApi.CoursesOffersTest do
  use QueroApi.DataCase

  alias QueroApi.CoursesOffers

  describe "courses_offers" do
    alias QueroApi.CoursesOffers.CoursesOffer

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def courses_offer_fixture(attrs \\ %{}) do
      {:ok, courses_offer} =
        attrs
        |> Enum.into(@valid_attrs)
        |> CoursesOffers.create_courses_offer()

      courses_offer
    end

    test "list_courses_offers/0 returns all courses_offers" do
      courses_offer = courses_offer_fixture()
      assert CoursesOffers.list_courses_offers() == [courses_offer]
    end

    test "get_courses_offer!/1 returns the courses_offer with given id" do
      courses_offer = courses_offer_fixture()
      assert CoursesOffers.get_courses_offer!(courses_offer.id) == courses_offer
    end

    test "create_courses_offer/1 with valid data creates a courses_offer" do
      assert {:ok, %CoursesOffer{} = courses_offer} = CoursesOffers.create_courses_offer(@valid_attrs)
    end

    test "create_courses_offer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = CoursesOffers.create_courses_offer(@invalid_attrs)
    end

    test "update_courses_offer/2 with valid data updates the courses_offer" do
      courses_offer = courses_offer_fixture()
      assert {:ok, %CoursesOffer{} = courses_offer} = CoursesOffers.update_courses_offer(courses_offer, @update_attrs)
    end

    test "update_courses_offer/2 with invalid data returns error changeset" do
      courses_offer = courses_offer_fixture()
      assert {:error, %Ecto.Changeset{}} = CoursesOffers.update_courses_offer(courses_offer, @invalid_attrs)
      assert courses_offer == CoursesOffers.get_courses_offer!(courses_offer.id)
    end

    test "delete_courses_offer/1 deletes the courses_offer" do
      courses_offer = courses_offer_fixture()
      assert {:ok, %CoursesOffer{}} = CoursesOffers.delete_courses_offer(courses_offer)
      assert_raise Ecto.NoResultsError, fn -> CoursesOffers.get_courses_offer!(courses_offer.id) end
    end

    test "change_courses_offer/1 returns a courses_offer changeset" do
      courses_offer = courses_offer_fixture()
      assert %Ecto.Changeset{} = CoursesOffers.change_courses_offer(courses_offer)
    end
  end
end
