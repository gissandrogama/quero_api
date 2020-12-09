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

data = File.read!("./priv/repo/db.json") |> Jason.decode!()
names_universities = Enum.map(data, fn names -> names["university"]["name"] end) |> Enum.uniq()

Enum.map(names_universities, fn name -> QueroApi.Seeds.university(name) end)
