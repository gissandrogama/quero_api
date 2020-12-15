defmodule QueroApi.Seeds.InsertCoursesOffers do
  @moduledoc """
  Esse modulo possui funçãos que inserem id de courses e offers na tabela courses_offers.
  """
  alias QueroApi.Seeds.InsertData

  def insert_courses_offers(courses, name) do
    Enum.filter(InsertData.db_json(), fn campu -> campu["university"]["name"] == name end)
    |> Enum.map(fn courses_offers ->
      {courses_offers["course"],
       %{
         "full_price" => courses_offers["full_price"],
         "price_with_discount" => courses_offers["price_with_discount"],
         "discount_percentage" => courses_offers["discount_percentage"],
         "start_date" => courses_offers["start_date"],
         "enrollment_semester" => courses_offers["enrollment_semester"],
         "enabled" => courses_offers["enabled"]
       }}
    end)
    |> assoc_course_offer(courses)
    |> Enum.map(fn offer -> QueroApi.Repo.update(offer) end)
  end

  def assoc_course_offer(offers_params, courses) do
    merger(offers_params, courses)
    |> Enum.map(fn {course, offer} ->
      {QueroApi.Repo.preload(course, [:campus, :offers]), offer}
    end)
    |> Enum.map(fn {course, offer} -> {QueroApi.Courses.change_course(course), offer} end)
    |> Enum.map(fn {course, offer} -> Ecto.Changeset.put_assoc(course, :offers, [offer]) end)
  end

  def merger(json, course_campus) do
    offers = QueroApi.Offers.list_offers()

    courses =
      Enum.map(course_campus, fn campus -> campus.courses end)
      |> Enum.map(fn course -> List.first(course) end)

    course_offers =
      for {course, offer} <- json,
          courses_map <- courses,
          course["name"] == courses_map.name,
          course["kind"] == courses_map.kind,
          course["level"] == courses_map.level,
          course["shift"] == courses_map.shift,
          do: {courses_map, offer}

    course_offers =
      for {course, offer} <- course_offers,
          offers_map <- offers,
          offer["full_price"] == offers_map.full_price,
          offer["price_with_discount"] == offers_map.price_with_discount,
          offer["discount_percentage"] == offers_map.discount_percentage,
          offer["start_date"] == offers_map.start_date,
          offer["enrollment_semester"] == offers_map.enrollment_semester,
          offer["enabled"] == offers_map.enabled,
          do: {course, offers_map}

    course_offers
  end
end
