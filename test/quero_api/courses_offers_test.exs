defmodule QueroApi.CoursesOffersTest do
  use QueroApi.DataCase, async: true

  import QueroApi.FixturesAll

  alias QueroApi.CoursesOffers

  describe "courses_offers" do
    alias QueroApi.CoursesOffers.CoursesOffer

    setup do
      course = courses_fixture()
      {:ok, course: course}
    end

    setup do
      offer = offers_fixture()
      {:ok, offer: offer}
    end

    setup do
      course_offer = offers_courses_fixture()
      {:ok, course_offer: course_offer}
    end

    # @valid_attrs %{course_id: course.id, offer_id: offer.id}
    # @update_attrs %{course_id: "2", offer_id: "20"}
    @invalid_attrs %{course_id: nil, offer_id: nil}

    test "list_courses_offers/0 returns all courses_offers", %{course_offer: course_offer} do
      assert CoursesOffers.list_courses_offers() == [course_offer]
    end

    test "get_courses_offer!/1 returns the courses_offer with given id", %{
      course_offer: course_offer
    } do
      assert CoursesOffers.get_courses_offer!(course_offer.id) == course_offer
    end

    test "create_courses_offer/1 with valid data creates a courses_offer", %{
      course: course,
      offer: offer
    } do
      assert {:ok, %CoursesOffer{} = course_offer} =
               CoursesOffers.create_courses_offer(%{course_id: course.id, offer_id: offer.id})

      assert course_offer.course_id == course.id
      assert course_offer.offer_id == offer.id
    end

    test "create_courses_offer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = CoursesOffers.create_courses_offer(@invalid_attrs)
    end

    test "change_courses_offer/1 insert ids that do not exist in leather and/or campu" do
      assert {:error, %Ecto.Changeset{}} =
               CoursesOffers.create_courses_offer(%{course_id: "4500", offer_id: "3474"})
    end

    test "update_courses_offer/2 with valid data updates the courses_offer", %{
      course_offer: course_offer
    } do
      course = courses_fixture()
      offer = offers_fixture()

      assert {:ok, %CoursesOffer{}} =
               CoursesOffers.update_courses_offer(course_offer, %{
                 course_id: course.id,
                 offer_id: offer.id
               })
    end

    test "update_courses_offer/2 with invalid data returns error changeset", %{
      course_offer: course_offer
    } do
      assert {:error, %Ecto.Changeset{}} =
               CoursesOffers.update_courses_offer(course_offer, @invalid_attrs)

      assert course_offer == CoursesOffers.get_courses_offer!(course_offer.id)
    end

    test "delete_courses_offer/1 deletes the courses_offer" do
      courses_offer = offers_courses_fixture()
      assert {:ok, %CoursesOffer{}} = CoursesOffers.delete_courses_offer(courses_offer)

      assert_raise Ecto.NoResultsError, fn ->
        CoursesOffers.get_courses_offer!(courses_offer.id)
      end
    end

    test "change_courses_offer/1 returns a courses_offer changeset" do
      courses_offer = offers_courses_fixture()
      assert %Ecto.Changeset{} = CoursesOffers.change_courses_offer(courses_offer)
    end
  end
end
