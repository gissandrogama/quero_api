# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     QueroApi.Repo.insert!(%QueroApi.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

# ler arquivo json "db.json" e transformar em uma lista
# alias QueroApi.{Repo, Universities, Campus, Courses, Offers}

campus_unip = ["Jardim das Indústrias", "Água Branca", "Jaguaré", "Parque São Jorge", "Paraíso"]
courses_unip = ["Engenharia Mecânica", "Jornalismo", "Biomedicina", "Arquitetura e Urbanismo", "Propaganda e Marketing"]
campus_anhembi = ["Vila Olímpia", "Bela Vista"]
campus_unicsul = ["Paulista", "Anália Franco", "Liberdade", "São Miguel Paulista"]
campus_anhanguera = ["Rio Comprido"]
campus_estacio = ["Patriolino Ribeiro", "Centro"]
campus_unopar = ["São José dos Campos", "Motorama"]
campus_etep = ["Jardim Esplanada"]

data = File.read!("./priv/repo/db.json") |> Jason.decode!()

#Tabela universiste
# criar uma lista universities, percorrer ela para inserir na tabela universities do banco de dados
universities =
  data
  |> Enum.map(fn data -> data["university"] end)
  |> Enum.map(fn university -> QueroApi.Universities.create_university(university) end)

universities = QueroApi.Universities.list_universities()

# Tabela Campus

# criar uma lista com os dados de campus
campus =
  data
  |> Enum.map(fn data -> data["campus"] end)
  |> Enum.map(fn campu -> QueroApi.Campus.create_campu(campu) end)

# transformar [%{"city" => "city", "name" => "name" }, ...] em [%{city: city", name: "name" }, ...] serão usados como parametros
# campus = Enum.map(campus, fn campu -> %{city: campu["city"], name: campu["name"]} end)

# # criar uma estrutura [{params, university}]
# university_params = Enum.zip(campus, universities)

# #fazer associação das universidades com os campos
# campus =
#   Enum.map(university_params, fn {params, university} ->
#     Ecto.build_assoc(university, :campus, params)
#   end)

# # inserir no banco
# Enum.map(campus, fn campu -> QueroApi.Repo.insert!(campu) end)

# campus = QueroApi.Campus.list_campus()

# Tabelas courses
# criar uma lista com os dados de courses, além de transformar [%{"city" => "city", "name" => "name" }, ...] em [%{city: city", name: "name" }, ...] serão usados como parametros
courses =
  data
  |> Enum.map(fn data -> data["course"] end)
  |> Enum.map(fn course -> QueroApi.Courses.create_course(course) end)


#   |> Enum.map(fn course ->
#     %{
#       name: course["name"],
#       kind: course["kind"],
#       level: course["level"],
#       shift: course["shift"]
#     }
#   end)

# # criar uma estrutura [{params, campus}]
# campus_params = Enum.zip(courses, campus)

# #associando tabelas campus e courses
# courses =
#   Enum.map(campus_params, fn {params, campu} ->
#     Ecto.build_assoc(campu, :courses, params)
#   end)

# # inserir dados na tabelas
# Enum.map(courses, fn course -> QueroApi.Repo.insert!(course) end)

# courses = QueroApi.Courses.list_courses()

#obter apenas as lista de maps de ofertas e inserir no banco
# data_new = Enum.map(data, fn data -> Map.pop(data, "campus") end) |> Enum.map(fn {campus, data} -> data end) |> Enum.map(fn data -> Map.pop(data, "course") end) |> Enum.map(fn {course, data} -> data end) |> Enum.map(fn data -> Map.pop(data, "university") end) |> Enum.map(fn {university, data} -> data end) |> Enum.map(fn ofertas -> QueroApi.Offers.create_offer(ofertas) end)

offers =
  data
  |> Enum.map(fn course -> %{ "full_price" => course["full_price"], "price_with_discount" => course["price_with_discount"], "discount_percentage" => course["discount_percentage"], "start_date" => course["start_date"], "enrollment_semester" => course["enrollment_semester"], "enabled" => course["enabled"]} end)
  |> Enum.map(fn offer -> QueroApi.Offers.create_offer(offer) end)



# Enum.map(fn course -> %{full_price: course["full_price"], price_with_discount: course["price_with_discount"], discount_percentage: course["discount_percentage"], start_date: course["start_date"], enrollment_semester: course["enrollment_semester"], enabled: course["enabled"]} end)

# # criar uma estrutura [{params, courses}]
# courses_params = Enum.zip(offers, courses)

# #associando tabelas courses e offers
# offers =
#   Enum.map(courses_params, fn {params, course} ->
#     Ecto.build_assoc(course, :offers, params)
#   end)

# # inserir dados na tabelas
# Enum.map(offers, fn offer -> QueroApi.Repo.insert!(offer) end)


#atualizar campo university_id da tabela campus
["UNIP", "Anhembi Morumbi", "UNICSUL", "Anhanguera", "Estácio", "Unopar",
 "ETEP"]
# campus que pertence a unip
unip = QueroApi.Repo.get_by(QueroApi.Universities.University, name: "UNIP")

campus = Enum.map(campus_unip, fn name ->
        QueroApi.Repo.get_by!(QueroApi.Campus.Campu, name: name)
        |> QueroApi.Repo.preload(:courses)
      end)

Enum.map(campus, fn campu ->
  QueroApi.Campus.update_campu(campu, %{university_id: unip.id})
end)


# campus que pertence a Anhembi Morumbi
anhembi = QueroApi.Repo.get_by(QueroApi.Universities.University, name: "Anhembi Morumbi")

campus = Enum.map(campus_anhembi, fn name ->
        QueroApi.Repo.get_by!(QueroApi.Campus.Campu, name: name)
        |> QueroApi.Repo.preload(:courses)
      end)

Enum.map(campus, fn campu ->
  QueroApi.Campus.update_campu(campu, %{university_id: anhembi.id})
end)

# campus que pertence a "UNICSUL"
unicsul = QueroApi.Repo.get_by(QueroApi.Universities.University, name: "UNICSUL")

campus = Enum.map(campus_unicsul, fn name ->
        QueroApi.Repo.get_by!(QueroApi.Campus.Campu, name: name)
        |> QueroApi.Repo.preload(:courses)
      end)

Enum.map(campus, fn campu ->
  QueroApi.Campus.update_campu(campu, %{university_id: unicsul.id})
end)

# campus que pertence a "Anhanguera"
anhanguera = QueroApi.Repo.get_by(QueroApi.Universities.University, name: "Anhanguera")

campus = Enum.map(campus_anhanguera, fn name ->
        QueroApi.Repo.get_by!(QueroApi.Campus.Campu, name: name)
        |> QueroApi.Repo.preload(:courses)
      end)

Enum.map(campus, fn campu ->
  QueroApi.Campus.update_campu(campu, %{university_id: anhanguera.id})
end)


# campus que pertence a "Estácio"
estacio = QueroApi.Repo.get_by(QueroApi.Universities.University, name: "Estácio")

campus = Enum.map(campus_estacio, fn name ->
        QueroApi.Repo.get_by!(QueroApi.Campus.Campu, name: name)
        |> QueroApi.Repo.preload(:courses)
      end)

Enum.map(campus, fn campu ->
  QueroApi.Campus.update_campu(campu, %{university_id: estacio.id})
end)

# campus que pertence a "Unopar"
unopar = QueroApi.Repo.get_by(QueroApi.Universities.University, name: "Unopar")

campus = Enum.map(campus_unopar, fn name ->
        QueroApi.Repo.get_by!(QueroApi.Campus.Campu, name: name)
        |> QueroApi.Repo.preload(:courses)
      end)

Enum.map(campus, fn campu ->
  QueroApi.Campus.update_campu(campu, %{university_id: unopar.id})
end)

# campus que pertence a "ETEP"
etep = QueroApi.Repo.get_by(QueroApi.Universities.University, name: "ETEP")

campus = Enum.map(campus_etep, fn name ->
        QueroApi.Repo.get_by!(QueroApi.Campus.Campu, name: name)
        |> QueroApi.Repo.preload(:courses)
      end)

Enum.map(campus, fn campu ->
  QueroApi.Campus.update_campu(campu, %{university_id: etep.id})
end)

#associação entre campus e courses

course = QueroApi.Courses.Course |> where([c], c.name == "Engenharia Mecânica") |> QueroApi.Repo.all()
#caso a lista estaja mais de um item
course = List.first(course)
campus = QueroApi.Repo.get_by(QueroApi.Campus.Campu, name: "Jardim das Indústrias") |> QueroApi.Repo.preload([:courses])
campus_changeset = Ecto.Changeset.change(campus)
campu_courses_changeset = campus_changeset |> Ecto.Changeset.put_assoc(:courses, [course])
QueroApi.Repo.update!(campu_courses_changeset)


data = File.read!("./priv/repo/db.json") |> Jason.decode!()

["UNIP", "Anhembi Morumbi", "UNICSUL", "Anhanguera", "Estácio", "Unopar", "ETEP"]

#listar campos da bando de dados
list_campus = QueroApi.Campus.list_campus

#lista de campus e curso de uma determinada universidade
lista_data_campus = Enum.filter(data, fn campus ->  campus["university"]["name"] == "Estácio" end)
lista_campus_courses = Enum.map(lista_data_university, fn campus_courses ->  {campus_courses["campus"], campus_courses["course"]} end)
lista_data_campus = Enum.map(lista_data_campus, fn {campus, courses} ->  {campus, %{name: courses["name"], kind: courses["kind"], level: courses["level"], shift: courses["shift"]}} end)


#juntar campus do banco com parametros de course
campus_courses = for {campu, course} <- lista_data_campus, campus <- list_campus, campu["name"] == campus.name,  do: {campus, course}
campus_courses = for {campu, course} <- campus_courses, courses_map <- courses, course["name"] == courses_map.name, course["kind"] == courses_map.kind, course["level"] == courses_map.level, course["shift"] == courses_map.shift,  do: {campu, courses_map}
campus_courses = Enum.map(campus_courses, fn {campus, courses} -> {QueroApi.Repo.preload(campus, :courses), courses} end)
campus_courses = Enum.map(campus_courses, fn {campus, courses} -> {QueroApi.Campus.change_campu(campus), courses} end)
campus_courses = Enum.map(campus_courses, fn {campus, courses} -> Ecto.Changeset.put_assoc(campus, :courses, [courses]) end)
Enum.map(campus_courses, fn courses -> QueroApi.Repo.update!(courses) end)

Enum.filter(data, fn campu -> campu["university"]["name"] == "Anhanguera" end)
Enum.map(list_anhanguera, fn courses_offers ->
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

course_offers = for {course, offer} <- list_course_offers, courses_map <- anhanguera, course["name"] == courses_map.name, course["kind"] == courses_map.kind, course["level"] == courses_map.level, course["shift"] == courses_map.shift, do: {courses_map, offer}
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

    course_offers = Enum.map(course_offers, fn {course, offer} -> {QueroApi.Repo.preload(course, :offers), offer} end)
    course_offers = Enum.map(course_offers, fn {course, offer} -> {QueroApi.Courses.change_course(course), offer} end)
    course_offers = Enum.map(course_offers, fn {course, offer} -> Ecto.Changeset.put_assoc(course, :offers, [offer]) end)
