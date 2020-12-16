defmodule QueroApiWeb.CourseControllerTest do
  use QueroApiWeb.ConnCase, async: true

  import QueroApi.FixturesAll
  alias QueroApi.CacheCourses
  alias QueroApi.Courses

  setup do
    %{user: user_fixture()}
  end

  setup do
    university = university_fixture(%{name: "UNIP"})
    campu = campus_fixture(%{university_id: university.id})

    course =
      courses_fixture(%{
        name: "Propaganda e Marketing",
        kind: "Presencial",
        level: "Bacharelado",
        shift: "Noite"
      })

    campus_courses_fixture(%{course_id: course.id, campu_id: campu.id})

    %{course: course}
    %{university: university}
    %{campu: campu}
  end

  setup do
    university2 = university_fixture(%{name: "UNAMA"})
    campu2 = campus_fixture(%{university_id: university2.id})

    course2 =
      courses_fixture(
        name: "Arquitetura e Urbanismo",
        kind: "Presencial",
        level: "Bacharelado",
        shift: "Manhã"
      )

    campus_courses_fixture(%{course_id: course2.id, campu_id: campu2.id})

    %{course: course2}
    %{university: university2}
    %{campu: campu2}
  end

  setup do
    university3 = university_fixture(%{name: "UFRA"})

    course3 =
      courses_fixture(%{
        name: "Biomedicina",
        kind: "Presencial",
        level: "Bacharelado",
        shift: "manhã"
      })

    campu3 = campus_fixture(%{university_id: university3.id})
    campus_courses_fixture(%{course_id: course3.id, campu_id: campu3.id})

    %{course: course3}
    %{university: university3}
    %{campu: campu3}
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "returns 200 with a list all courses", %{conn: conn} do
      conn =
        get(conn, Routes.course_path(conn, :index), %{
          "kind" => "",
          "level" => "",
          "university" => "",
          "shift" => ""
        })

      assert json_response(conn, 200)["data"] ==
               Courses.filter(
                 %{
                   university: "",
                   kind: "",
                   level: "",
                   shift: ""
                 },
                 CacheCourses.get()
               )
               |> Enum.map(fn data ->
                 %{
                   "course" => %{
                     "campus" => %{"city" => data.campus.city, "name" => data.campus.name},
                     "kind" => data.course.kind,
                     "level" => data.course.level,
                     "name" => data.course.name,
                     "shift" => data.course.shift,
                     "university" => %{
                       "logo_url" => data.university.logo_url,
                       "name" => data.university.name,
                       "score" => data.university.score
                     }
                   }
                 }
               end)
    end

    test "list courses by kind, level, name", %{conn: conn} do
      conn =
        get(conn, Routes.course_path(conn, :index), %{
          "kind" => "Presencial",
          "level" => "Bacharelado",
          "university" => "UFRA",
          "shift" => ""
        })

      assert json_response(conn, 200)["data"] ==
               Courses.filter(
                 %{
                   university: "UFRA",
                   kind: "Presencial",
                   level: "Bacharelado"
                 },
                 CacheCourses.get()
               )
               |> Enum.map(fn data ->
                 %{
                   "course" => %{
                     "campus" => %{"city" => data.campus.city, "name" => data.campus.name},
                     "kind" => data.course.kind,
                     "level" => data.course.level,
                     "name" => data.course.name,
                     "shift" => data.course.shift,
                     "university" => %{
                       "logo_url" => data.university.logo_url,
                       "name" => data.university.name,
                       "score" => data.university.score
                     }
                   }
                 }
               end)
    end

    test "list courses by shift", %{conn: conn} do
      conn =
        get(conn, Routes.course_path(conn, :index), %{
          "kind" => "",
          "level" => "",
          "university" => "",
          "shift" => "noite"
        })

      assert json_response(conn, 200)["data"] ==
               Courses.filter(
                 %{
                   shift: "noite"
                 },
                 CacheCourses.get()
               )
               |> Enum.map(fn data ->
                 %{
                   "course" => %{
                     "campus" => %{"city" => data.campus.city, "name" => data.campus.name},
                     "kind" => data.course.kind,
                     "level" => data.course.level,
                     "name" => data.course.name,
                     "shift" => data.course.shift,
                     "university" => %{
                       "logo_url" => data.university.logo_url,
                       "name" => data.university.name,
                       "score" => data.university.score
                     }
                   }
                 }
               end)
    end

    test "list courses by all parameters", %{conn: conn} do
      conn =
        get(conn, Routes.course_path(conn, :index), %{
          "kind" => "Presencial",
          "level" => "Bacharelado",
          "university" => "UNAMA",
          "shift" => "manhã"
        })

      assert json_response(conn, 200)["data"] ==
               Courses.filter(
                 %{
                   university: "UNAMA",
                   kind: "Presencial",
                   level: "Bacharelado",
                   shift: "Manhã"
                 },
                 CacheCourses.get()
               )
               |> Enum.map(fn data ->
                 %{
                   "course" => %{
                     "campus" => %{"city" => data.campus.city, "name" => data.campus.name},
                     "kind" => data.course.kind,
                     "level" => data.course.level,
                     "name" => data.course.name,
                     "shift" => data.course.shift,
                     "university" => %{
                       "logo_url" => data.university.logo_url,
                       "name" => data.university.name,
                       "score" => data.university.score
                     }
                   }
                 }
               end)
    end

    test "passing parameters that don't exist in the bank", %{conn: conn} do
      conn =
        get(conn, Routes.course_path(conn, :index), %{
          "kind" => "Presencial",
          "level" => "tecnologo",
          "university" => "UNAMA",
          "shift" => "Manhã"
        })

      assert json_response(conn, 200)["data"] == []
    end
  end
end
