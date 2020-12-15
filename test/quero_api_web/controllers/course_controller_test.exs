defmodule QueroApiWeb.CourseControllerTest do
  use QueroApiWeb.ConnCase, async: true

  import QueroApi.FixturesAll
  # alias QueroApi.CacheCourses

  setup do
    %{user: user_fixture()}
  end

  setup do
    university = university_fixture(%{name: "ufra"})
    campu = campus_fixture(%{university_id: university.id})
    course = courses_fixture()
    campus_courses_fixture(%{course_id: course.id, campu_id: campu.id})

    %{university: university}
    %{campu: campu}
    %{course: course}
  end

  setup do
    university = university_fixture(%{name: "unama"})
    campu = campus_fixture(%{university_id: university.id})
    course = courses_fixture()
    campus_courses_fixture(%{course_id: course.id, campu_id: campu.id})

    %{university: university}
    %{campu: campu}
    %{course: course}
  end

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

      result = conn.resp_body |> Jason.decode!()
      result = result["data"]

      assert json_response(conn, 200)["data"] == result
              #  Enum.map(CacheCourses.get(), fn data ->
              #    %{
              #      "course" => %{
              #        "campus" => %{"city" => data.campus.city, "name" => data.campus.name},
              #        "kind" => data.course.kind,
              #        "level" => data.course.level,
              #        "name" => data.course.name,
              #        "shift" => data.course.shift,
              #        "university" => %{
              #          "logo_url" => data.university.logo_url,
              #          "name" => data.university.name,
              #          "score" => data.university.score
              #        }
              #      }
              #    }
              #  end)
    end

    test "lists all courses", %{conn: conn} do
      conn =
        get(conn, Routes.course_path(conn, :index), %{
          "kind" => "",
          "level" => "",
          "university" => "",
          "shift" => ""
        })

      assert json_response(conn, 200)["data"] == []
              #  Enum.map(CacheCourses.get(), fn data ->
              #    %{
              #      "course" => %{
              #        "campus" => %{"city" => data.campus.city, "name" => data.campus.name},
              #        "kind" => data.course.kind,
              #        "level" => data.course.level,
              #        "name" => data.course.name,
              #        "shift" => data.course.shift,
              #        "university" => %{
              #          "logo_url" => data.university.logo_url,
              #          "name" => data.university.name,
              #          "score" => data.university.score
              #        }
              #      }
              #    }
              #  end)
    end

    # test "list courses by university name e kind", %{conn: conn} do
    #   university2 = university_fixture(%{name: "UFRA"})

    #   course2 = courses_fixture(%{kind: "EAD"})

    #   campu2 = campus_fixture(%{university_id: university2.id})

    #   campus_courses_fixture(%{course_id: course2.id, campu_id: campu2.id})

    #   conn =
    #     get(conn, Routes.course_path(conn, :index), %{
    #       "kind" => "ead",
    #       "level" => "",
    #       "university" => "UFRA",
    #       "shift" => ""
    #     })

    #   assert json_response(conn, 200)["data"] == [
    #            %{
    #              "course" => %{
    #                "campus" => %{"city" => campu2.city, "name" => campu2.name},
    #                "kind" => "EAD",
    #                "level" => course2.level,
    #                "name" => course2.name,
    #                "shift" => course2.shift,
    #                "university" => %{
    #                  "logo_url" => university2.logo_url,
    #                  "name" => "UFRA",
    #                  "score" => university2.score
    #                }
    #              }
    #            }
    #          ]
    # end

    # test "list courses by kind, level, name", %{conn: conn} do
    #   university3 = university_fixture(%{name: "UFPA"})

    #   course3 = courses_fixture(%{kind: "Presencial", level: "Licenciatura"})

    #   campu3 = campus_fixture(%{university_id: university3.id})

    #   campus_courses_fixture(%{course_id: course3.id, campu_id: campu3.id})

    #   conn =
    #     get(conn, Routes.course_path(conn, :index), %{
    #       "kind" => "presencial",
    #       "level" => "licenciatura",
    #       "university" => "",
    #       "shift" => ""
    #     })

    #   assert json_response(conn, 200)["data"] ==
    #            [
    #              %{
    #                "course" => %{
    #                  "campus" => %{"city" => campu3.city, "name" => campu3.name},
    #                  "kind" => course3.kind,
    #                  "level" => course3.level,
    #                  "name" => course3.name,
    #                  "shift" => course3.shift,
    #                  "university" => %{
    #                    "logo_url" => university3.logo_url,
    #                    "name" => university3.name,
    #                    "score" => university3.score
    #                  }
    #                }
    #              }
    #            ]
    # end

    # test "list courses by level", %{conn: conn} do
    #   university = university_fixture()

    #   course = courses_fixture(%{level: "Bacharelado"})

    #   campu = campus_fixture(%{university_id: university.id})

    #   campus_courses_fixture(%{course_id: course.id, campu_id: campu.id})

    #   conn =
    #     get(conn, Routes.course_path(conn, :index), %{
    #       "kind" => "",
    #       "level" => "Bacharelado",
    #       "university" => "",
    #       "shift" => ""
    #     })

    #   assert json_response(conn, 200)["data"] ==
    #            Enum.map(Cache.get(), fn data ->
    #              %{
    #                "course" => %{
    #                  "campus" => %{"city" => data.campus.city, "name" => data.campus.name},
    #                  "kind" => data.course.kind,
    #                  "level" => data.course.level,
    #                  "name" => data.course.name,
    #                  "shift" => data.course.shift,
    #                  "university" => %{
    #                    "logo_url" => data.university.logo_url,
    #                    "name" => data.university.name,
    #                    "score" => data.university.score
    #                  }
    #                }
    #              }
    #            end)
    # end

    # test "list courses by shift", %{conn: conn} do
    #   university = university_fixture()

    #   course = courses_fixture(%{shift: "Noite"})

    #   campu = campus_fixture(%{university_id: university.id})

    #   campus_courses_fixture(%{course_id: course.id, campu_id: campu.id})

    #   conn =
    #     get(conn, Routes.course_path(conn, :index), %{
    #       "kind" => "",
    #       "level" => "",
    #       "university" => "",
    #       "shift" => "Noite"
    #     })

    #   assert json_response(conn, 200)["data"] ==
    #            Enum.map(Cache.get(), fn data ->
    #              %{
    #                "course" => %{
    #                  "campus" => %{"city" => data.campus.city, "name" => data.campus.name},
    #                  "kind" => data.course.kind,
    #                  "level" => data.course.level,
    #                  "name" => data.course.name,
    #                  "shift" => data.course.shift,
    #                  "university" => %{
    #                    "logo_url" => data.university.logo_url,
    #                    "name" => data.university.name,
    #                    "score" => data.university.score
    #                  }
    #                }
    #              }
    #            end)
    # end

    # test "list courses by all parameters", %{conn: conn} do
    #   university = university_fixture(%{name: "UFPA"})

    #   course = courses_fixture(%{kind: "Presencial", level: "Bacharelado", shift: "Manhã"})

    #   campu = campus_fixture(%{university_id: university.id})

    #   campus_courses_fixture(%{course_id: course.id, campu_id: campu.id})

    #   university2 = university_fixture(%{name: "UFRA"})

    #   course2 = courses_fixture(%{kind: "Presencial", level: "Bacharelado", shift: "Noite"})

    #   campu2 = campus_fixture(%{university_id: university2.id})

    #   campus_courses_fixture(%{course_id: course2.id, campu_id: campu2.id})

    #   conn =
    #     get(conn, Routes.course_path(conn, :index), %{
    #       "kind" => "Presencial",
    #       "level" => "Bacharelado",
    #       "university" => "UFPA",
    #       "shift" => "Manhã"
    #     })

    #   assert json_response(conn, 200)["data"] ==
    #            Enum.map(Cache.get(), fn data ->
    #              %{
    #                "course" => %{
    #                  "campus" => %{"city" => data.campus.city, "name" => data.campus.name},
    #                  "kind" => data.course.kind,
    #                  "level" => data.course.level,
    #                  "name" => data.course.name,
    #                  "shift" => data.course.shift,
    #                  "university" => %{
    #                    "logo_url" => data.university.logo_url,
    #                    "name" => data.university.name,
    #                    "score" => data.university.score
    #                  }
    #                }
    #              }
    #            end)
    # end

    # test "passing parameters that don't exist in the bank", %{conn: conn} do
    #   university = university_fixture()

    #   course = courses_fixture()

    #   campu = campus_fixture(%{university_id: university.id})

    #   campus_courses_fixture(%{course_id: course.id, campu_id: campu.id})

    #   conn =
    #     get(conn, Routes.course_path(conn, :index), %{
    #       "kind" => "Presencial",
    #       "level" => "Bacharelado",
    #       "university" => "UNAMA",
    #       "shift" => "Manhã"
    #     })

    #   assert json_response(conn, 200)["data"] == []
    # end

    # defp create_courses(_) do
    #   university = university_fixture()
    #   campu = campus_fixture(%{university_id: university.id})
    #   course = courses_fixture()
    #   campus_courses_fixture(%{course_id: course.id, campu_id: campu.id})

    #   %{university: university, campu: campu, course: course}
    # end
  end
end
