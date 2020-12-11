defmodule QueroApiWeb.CourseControllerTest do
  use QueroApiWeb.ConnCase, async: true

  import QueroApi.FixturesAll

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "returns 200 with a list of courses", %{conn: conn} do
      conn =
        get(conn, Routes.course_path(conn, :index), %{
          "kind" => "",
          "level" => "",
          "university" => "",
          "shift" => ""
        })

      assert json_response(conn, 200)["data"] == []
    end

    test "lists all courses", %{conn: conn} do
      university = university_fixture()

      course = courses_fixture()

      campu = campus_fixture(%{university_id: university.id})

      campus_courses_fixture(%{course_id: course.id, campu_id: campu.id})

      conn =
        get(conn, Routes.course_path(conn, :index), %{
          "kind" => "",
          "level" => "",
          "university" => "",
          "shift" => ""
        })

      assert json_response(conn, 200)["data"] == [
               %{
                 "course" => %{
                   "campus" => %{"city" => campu.city, "name" => campu.name},
                   "kind" => course.kind,
                   "level" => course.level,
                   "name" => course.name,
                   "shift" => course.shift,
                   "university" => %{
                     "logo_url" => university.logo_url,
                     "name" => university.name,
                     "score" => university.score
                   }
                 }
               }
             ]
    end

    test "list courses by university name", %{conn: conn} do
      university = university_fixture(%{name: "UFRA"})

      course = courses_fixture()

      campu = campus_fixture(%{university_id: university.id})

      campus_courses_fixture(%{course_id: course.id, campu_id: campu.id})

      conn =
        get(conn, Routes.course_path(conn, :index), %{
          "kind" => "",
          "level" => "",
          "university" => "UFRA",
          "shift" => ""
        })

      assert json_response(conn, 200)["data"] == [
               %{
                 "course" => %{
                   "campus" => %{"city" => campu.city, "name" => campu.name},
                   "kind" => course.kind,
                   "level" => course.level,
                   "name" => course.name,
                   "shift" => course.shift,
                   "university" => %{
                     "logo_url" => university.logo_url,
                     "name" => university.name,
                     "score" => university.score
                   }
                 }
               }
             ]
    end

    test "list courses by kind", %{conn: conn} do
      university = university_fixture()

      course = courses_fixture(%{kind: "Presencial"})

      campu = campus_fixture(%{university_id: university.id})

      campus_courses_fixture(%{course_id: course.id, campu_id: campu.id})

      conn =
        get(conn, Routes.course_path(conn, :index), %{
          "kind" => "Presencial",
          "level" => "",
          "university" => "",
          "shift" => ""
        })

      assert json_response(conn, 200)["data"] == [
               %{
                 "course" => %{
                   "campus" => %{"city" => campu.city, "name" => campu.name},
                   "kind" => course.kind,
                   "level" => course.level,
                   "name" => course.name,
                   "shift" => course.shift,
                   "university" => %{
                     "logo_url" => university.logo_url,
                     "name" => university.name,
                     "score" => university.score
                   }
                 }
               }
             ]
    end

    test "list courses by level", %{conn: conn} do
      university = university_fixture()

      course = courses_fixture(%{level: "Bacharelado"})

      campu = campus_fixture(%{university_id: university.id})

      campus_courses_fixture(%{course_id: course.id, campu_id: campu.id})

      conn =
        get(conn, Routes.course_path(conn, :index), %{
          "kind" => "",
          "level" => "Bacharelado",
          "university" => "",
          "shift" => ""
        })

      assert json_response(conn, 200)["data"] == [
               %{
                 "course" => %{
                   "campus" => %{"city" => campu.city, "name" => campu.name},
                   "kind" => course.kind,
                   "level" => course.level,
                   "name" => course.name,
                   "shift" => course.shift,
                   "university" => %{
                     "logo_url" => university.logo_url,
                     "name" => university.name,
                     "score" => university.score
                   }
                 }
               }
             ]
    end

    test "list courses by shift", %{conn: conn} do
      university = university_fixture()

      course = courses_fixture(%{shift: "Noite"})

      campu = campus_fixture(%{university_id: university.id})

      campus_courses_fixture(%{course_id: course.id, campu_id: campu.id})

      university2 = university_fixture()

      course2 = courses_fixture(%{shift: "Manhã"})

      campu2 = campus_fixture(%{university_id: university2.id})

      campus_courses_fixture(%{course_id: course2.id, campu_id: campu2.id})

      conn =
        get(conn, Routes.course_path(conn, :index), %{
          "kind" => "",
          "level" => "",
          "university" => "",
          "shift" => "Noite"
        })

      assert json_response(conn, 200)["data"] == [
               %{
                 "course" => %{
                   "campus" => %{"city" => campu.city, "name" => campu.name},
                   "kind" => course.kind,
                   "level" => course.level,
                   "name" => course.name,
                   "shift" => course.shift,
                   "university" => %{
                     "logo_url" => university.logo_url,
                     "name" => university.name,
                     "score" => university.score
                   }
                 }
               }
             ]
    end

    test "list courses by all parameters", %{conn: conn} do
      university = university_fixture(%{name: "UFPA"})

      course = courses_fixture(%{kind: "Presencial", level: "Bacharelado", shift: "Manhã"})

      campu = campus_fixture(%{university_id: university.id})

      campus_courses_fixture(%{course_id: course.id, campu_id: campu.id})

      university2 = university_fixture(%{name: "UFRA"})

      course2 = courses_fixture(%{kind: "Presencial", level: "Bacharelado", shift: "Noite"})

      campu2 = campus_fixture(%{university_id: university2.id})

      campus_courses_fixture(%{course_id: course2.id, campu_id: campu2.id})

      conn =
        get(conn, Routes.course_path(conn, :index), %{
          "kind" => "Presencial",
          "level" => "Bacharelado",
          "university" => "UFPA",
          "shift" => "Manhã"
        })

      assert json_response(conn, 200)["data"] == [
               %{
                 "course" => %{
                   "campus" => %{"city" => campu.city, "name" => campu.name},
                   "kind" => course.kind,
                   "level" => course.level,
                   "name" => course.name,
                   "shift" => course.shift,
                   "university" => %{
                     "logo_url" => university.logo_url,
                     "name" => university.name,
                     "score" => university.score
                   }
                 }
               }
             ]
    end

    test "passing parameters that don't exist in the bank", %{conn: conn} do
      university = university_fixture()

      course = courses_fixture()

      campu = campus_fixture(%{university_id: university.id})

      campus_courses_fixture(%{course_id: course.id, campu_id: campu.id})

      conn =
        get(conn, Routes.course_path(conn, :index), %{
          "kind" => "Presencial",
          "level" => "Bacharelado",
          "university" => "UFPA",
          "shift" => "Manhã"
        })

      assert json_response(conn, 200)["data"] == []
    end
  end
end
