defmodule QueroApi.FixturesAll do
  @moduledoc """
  This module defines test helpers to create entities through campus, courses,
  offers, campus_offers and courses_offers contexts.
  """

  alias QueroApi.{Accounts, Campus, CampusCourses, Courses, CoursesOffers, Offers, Universities}

  def email, do: "email-#{System.unique_integer()}@email.com"
  def password, do: "123456"
  def password_confirmation, do: "123456"

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: email(),
        password: password(),
        password_confirmation: password_confirmation()
      })
      |> Accounts.create_user()

    user
  end

  def name_university, do: "University 1-#{System.unique_integer()}"

  def score, do: 4.5
  def logo_url, do: "https://www.tryimg.com/u/2019/04/16/anhanguera.png"

  def university_fixture(attrs \\ %{}) do
    {:ok, university} =
      attrs
      |> Enum.into(%{
        name: name_university(),
        score: score(),
        logo_url: logo_url()
      })
      |> Universities.create_university()

    university
  end

  def name_campus, do: "some name-#{System.unique_integer()}"
  def city, do: "some cyte"
  def university_id, do: university_fixture()

  def campus_fixture(attrs \\ %{}) do
    {:ok, campus} =
      attrs
      |> Enum.into(%{
        name: name_campus(),
        city: city(),
        university_id: university_id().id
      })
      |> Campus.create_campu()

    campus
  end

  def campu_course_id, do: campus_fixture()
  def course_campu_id, do: courses_fixture()

  def campus_courses_fixture(attrs \\ %{}) do
    {:ok, campu_course} =
      attrs
      |> Enum.into(%{
        course_id: course_campu_id().id,
        campu_id: campu_course_id().id
      })
      |> CampusCourses.create_campus_course()

    campu_course
  end

  def kind, do: "some kind"
  def level, do: "some level"
  # def name_course(name), do: name
  def name_course, do: "some name-#{System.unique_integer()}"
  def shift, do: "some shift"

  def courses_fixture(attrs \\ %{}) do
    {:ok, courses} =
      attrs
      |> Enum.into(%{
        kind: kind(),
        level: level(),
        name: name_course(),
        shift: shift()
      })
      |> Courses.create_course()

    courses
  end

  def course_offer_id, do: courses_fixture()
  def offer_course_id, do: offers_fixture()

  def offers_courses_fixture(attrs \\ %{}) do
    {:ok, offer_course} =
      attrs
      |> Enum.into(%{
        course_id: course_offer_id().id,
        offer_id: offer_course_id().id
      })
      |> CoursesOffers.create_courses_offer()

    offer_course
  end

  def discount_percentage, do: 10.5
  def enabled, do: true
  def enrollment_semester, do: "some enrollment_semester"
  def full_price, do: 120.5
  def price_with_discount, do: 80.9
  # def start_date(start_date), do: start_date
  def start_date, do: "some start_date-#{System.unique_integer()}"

  def offers_fixture(attrs \\ %{}) do
    {:ok, offers} =
      attrs
      |> Enum.into(%{
        discount_percentage: discount_percentage(),
        enabled: enabled(),
        enrollment_semester: enrollment_semester(),
        full_price: full_price(),
        price_with_discount: price_with_discount(),
        start_date: start_date()
      })
      |> Offers.create_offer()

    offers
  end
end
