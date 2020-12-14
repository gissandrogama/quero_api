defmodule QueroApi.Seeds do
  @moduledoc """
  Este modulo possui funções que automatizão a inserção de dados apartir de um arquivo json e
  mapeia das associações de relações do banco de dados.
  """

  @spec university(String) :: [map()]
  def university(name) do
    insert_courses()
    insert_offers()

    Enum.filter(db_json(), fn universities -> universities["university"]["name"] == name end)
    |> insert_university()
    |> insert_campus(name)
    |> insert_campus_courses(name)
    |> insert_courses_offers(name)
  end

  @doc """
  função que ler o arquivo json
  """
  @spec db_json :: [map()]
  def db_json do
    File.read!("./priv/repo/db.json") |> Jason.decode!()
  end

  defp insert_university(data) do
    data
    |> Enum.map(fn univer -> univer["university"] end)
    |> List.first()
    |> QueroApi.Universities.create_university()
  end

  defp insert_campus(university, name) do
    {:ok, university} = university

    Enum.filter(db_json(), fn universities -> universities["university"]["name"] == name end)
    |> Enum.map(fn univer -> univer["campus"] end)
    |> Enum.map(fn campu -> %{city: campu["city"], name: campu["name"]} end)
    |> Enum.uniq_by(fn campu -> campu.name end)
    |> Enum.map(fn campu -> Ecto.build_assoc(university, :campus, campu) end)
    |> Enum.map(fn campu -> QueroApi.Repo.insert!(campu) end)
  end

  defp insert_campus_courses(campus, name) do
    Enum.filter(db_json(), fn campu -> campu["university"]["name"] == name end)
    |> Enum.map(fn campus -> {campus["campus"], campus["course"]} end)
    |> assoc_campus_course(campus)
    |> Enum.map(fn courses -> QueroApi.Repo.update!(courses) end)
  end

  defp assoc_campus_course(courses_params, campus) do
    courses = QueroApi.Courses.list_courses()

    campus_courses =
      for {campu, course} <- courses_params,
          campus_map <- campus,
          campu["name"] == campus_map.name,
          do: {campus_map, course}

    campus_courses =
      for {campu, course} <- campus_courses,
          courses_map <- courses,
          course["name"] == courses_map.name,
          course["kind"] == courses_map.kind,
          course["level"] == courses_map.level,
          course["shift"] == courses_map.shift,
          do: {campu, courses_map}

    campus_courses
    |> Enum.map(fn {campu, course} ->
      {QueroApi.Repo.preload(campu, [:university, :courses]), course}
    end)
    |> Enum.map(fn {campu, course} -> {QueroApi.Campus.change_campu(campu), course} end)
    |> Enum.map(fn {campu, course} -> Ecto.Changeset.put_assoc(campu, :courses, [course]) end)
  end

  def insert_courses_offers(courses, name) do
    Enum.filter(db_json(), fn campu -> campu["university"]["name"] == name end)
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

  defp assoc_course_offer(offers_params, courses) do
    offers = QueroApi.Offers.list_offers()

    courses =
      Enum.map(courses, fn campus -> campus.courses end)
      |> Enum.map(fn courses -> List.first(courses) end)

    course_offers =
      for {course, offer} <- offers_params,
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
    |> Enum.map(fn {course, offer} ->
      {QueroApi.Repo.preload(course, [:campus, :offers]), offer}
    end)
    |> Enum.map(fn {course, offer} -> {QueroApi.Courses.change_course(course), offer} end)
    |> Enum.map(fn {course, offer} -> Ecto.Changeset.put_assoc(course, :offers, [offer]) end)
  end

  @spec insert_courses :: [map()]
  def insert_courses do
    Enum.filter(db_json(), fn offers -> offers["course"] end)
    |> Enum.map(fn courses -> courses["course"] end)
    |> Enum.uniq()
    |> Enum.map(fn course -> QueroApi.Courses.create_course(course) end)
  end

  @spec insert_offers :: [map()]
  def insert_offers do
    Enum.filter(db_json(), fn offers ->
      %{
        "full_price" => offers["full_price"],
        "price_with_discount" => offers["price_with_discount"],
        "discount_percentage" => offers["discount_percentage"],
        "start_date" => offers["start_date"],
        "enrollment_semester" => offers["enrollment_semester"],
        "enabled" => offers["enabled"]
      }
    end)
    |> Enum.uniq()
    |> Enum.map(fn offer -> QueroApi.Offers.create_offer(offer) end)
  end
end
