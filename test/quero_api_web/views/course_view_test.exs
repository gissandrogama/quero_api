defmodule QueroApi.CourseViewTest do
  use QueroApi.DataCase, async: true

  import QueroApi.FixturesAll

  alias QueroApiWeb.CourseView

  describe "index.json" do
    test "render/2 returns a list a of courses" do
      university = university_fixture(%{name: "UFRA", score: "4.5", logo_url: "https://ufra.org"})

      course =
        courses_fixture(%{
          name: "Sistema de informação",
          kind: "Presencial",
          level: "Bacharelado",
          shift: "Manhã"
        })

      campu = campus_fixture(%{name: "Belém", city: "Belém", university_id: university.id})
      campus_courses_fixture(%{campu_id: campu.id, course_id: course.id})

      courses = [[course: course, university: university, campus: campu]]

      assert %{
               data: [
                 %{
                   course: %{
                     name: "Sistema de informação",
                     kind: "Presencial",
                     level: "Bacharelado",
                     shift: "Manhã",
                     university: %{
                       name: "UFRA",
                       score: 4.5,
                       logo_url: "https://ufra.org"
                     },
                     campus: %{
                       name: "Belém",
                       city: "Belém"
                     }
                   }
                 }
               ]
             } == CourseView.render("index.json", %{courses: courses})
    end
  end
end
