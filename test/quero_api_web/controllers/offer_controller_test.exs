defmodule QueroApiWeb.OfferControllerTest do
  use QueroApiWeb.ConnCase, async: true

  import QueroApiWeb.UserAurh
  import QueroApi.FixturesAll
  alias QueroApi.CacheOffers
  alias QueroApi.Offers

  setup do
    university = university_fixture(%{name: "UNIP"})
    campu = campus_fixture(%{city: "São Paulo", university_id: university.id})

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
    campu2 = campus_fixture(%{city: "Belém", university_id: university2.id})

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

    campu3 = campus_fixture(%{city: "Belém", university_id: university3.id})
    campus_courses_fixture(%{course_id: course3.id, campu_id: campu3.id})

    %{course: course3}
    %{university: university3}
    %{campu: campu3}
  end

  setup %{conn: conn} do
    conn = authenticate(conn)
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "returns 200 with a list of offers", %{conn: conn} do
      conn =
        get(conn, Routes.offer_path(conn, :index), %{
          "city" => "",
          "course" => "",
          "kind" => "",
          "level" => "",
          "shift" => "",
          "university" => "",
          "prices" => ""
        })

      assert json_response(conn, 200)["data"] ==
               Offers.filter(
                 %{
                   kind: "",
                   level: "",
                   university: "",
                   shift: "",
                   course: "",
                   city: "",
                   prices: ""
                 },
                 CacheOffers.get()
               )
               |> Enum.map(fn data ->
                 %{
                   "full_price" => data.offer.full_price,
                   "price_with_discount" => data.offer.price_with_discount,
                   "discount_percentage" => data.offer.discount_percentage,
                   "start_date" => data.offer.start_date,
                   "enrollment_semester" => data.offer.enrollment_semester,
                   "enabled" => data.offer.enabled,
                   "course" => %{
                     "name" => data.course.name,
                     "kind" => data.course.kind,
                     "level" => data.course.level,
                     "shift" => data.course.shift
                   },
                   "university" => %{
                     "name" => data.university.name,
                     "score" => data.university.score,
                     "logo_url" => data.university.logo_url
                   },
                   "campus" => %{
                     "name" => data.campu.name,
                     "city" => data.campu.city
                   }
                 }
               end)
    end

    test "list offers by university name", %{conn: conn} do
      conn =
        get(conn, Routes.offer_path(conn, :index), %{
          "city" => "",
          "course" => "",
          "kind" => "",
          "level" => "",
          "shift" => "",
          "university" => "UNAMA",
          "prices" => ""
        })

      assert json_response(conn, 200)["data"] ==
               Offers.filter(
                 %{
                   kind: "",
                   level: "",
                   university: "UNAMA",
                   shift: "",
                   course: "",
                   city: "",
                   prices: ""
                 },
                 CacheOffers.get()
               )
               |> Enum.map(fn data ->
                 %{
                   "full_price" => data.offer.full_price,
                   "price_with_discount" => data.offer.price_with_discount,
                   "discount_percentage" => data.offer.discount_percentage,
                   "start_date" => data.offer.start_date,
                   "enrollment_semester" => data.offer.enrollment_semester,
                   "enabled" => data.offer.enabled,
                   "course" => %{
                     "name" => data.course.name,
                     "kind" => data.course.kind,
                     "level" => data.course.level,
                     "shift" => data.course.shift
                   },
                   "university" => %{
                     "name" => data.university.name,
                     "score" => data.university.score,
                     "logo_url" => data.university.logo_url
                   },
                   "campus" => %{
                     "name" => data.campu.name,
                     "city" => data.campu.city
                   }
                 }
               end)
    end

    test "list offers by course name", %{conn: conn} do
      conn =
        get(conn, Routes.offer_path(conn, :index), %{
          "city" => "",
          "course" => "Biomedicina",
          "kind" => "",
          "level" => "",
          "shift" => "",
          "university" => "",
          "prices" => ""
        })

      assert json_response(conn, 200)["data"] ==
               Offers.filter(
                 %{
                   kind: "",
                   level: "",
                   university: "",
                   shift: "",
                   course: "Biomedicina",
                   city: "",
                   prices: ""
                 },
                 CacheOffers.get()
               )
               |> Enum.map(fn data ->
                 %{
                   "full_price" => data.offer.full_price,
                   "price_with_discount" => data.offer.price_with_discount,
                   "discount_percentage" => data.offer.discount_percentage,
                   "start_date" => data.offer.start_date,
                   "enrollment_semester" => data.offer.enrollment_semester,
                   "enabled" => data.offer.enabled,
                   "course" => %{
                     "name" => data.course.name,
                     "kind" => data.course.kind,
                     "level" => data.course.level,
                     "shift" => data.course.shift
                   },
                   "university" => %{
                     "name" => data.university.name,
                     "score" => data.university.score,
                     "logo_url" => data.university.logo_url
                   },
                   "campus" => %{
                     "name" => data.campu.name,
                     "city" => data.campu.city
                   }
                 }
               end)
    end

    test "list offers by city name", %{conn: conn} do
      conn =
        get(conn, Routes.offer_path(conn, :index), %{
          "city" => "Belém",
          "course" => "",
          "kind" => "",
          "level" => "",
          "shift" => "",
          "university" => "",
          "prices" => ""
        })

      assert json_response(conn, 200)["data"] ==
               Offers.filter(
                 %{
                   kind: "",
                   level: "",
                   university: "",
                   shift: "",
                   course: "",
                   city: "belem",
                   prices: ""
                 },
                 CacheOffers.get()
               )
               |> Enum.map(fn data ->
                 %{
                   "full_price" => data.offer.full_price,
                   "price_with_discount" => data.offer.price_with_discount,
                   "discount_percentage" => data.offer.discount_percentage,
                   "start_date" => data.offer.start_date,
                   "enrollment_semester" => data.offer.enrollment_semester,
                   "enabled" => data.offer.enabled,
                   "course" => %{
                     "name" => data.course.name,
                     "kind" => data.course.kind,
                     "level" => data.course.level,
                     "shift" => data.course.shift
                   },
                   "university" => %{
                     "name" => data.university.name,
                     "score" => data.university.score,
                     "logo_url" => data.university.logo_url
                   },
                   "campus" => %{
                     "name" => data.campu.name,
                     "city" => data.campu.city
                   }
                 }
               end)
    end

    test "list offers by kind", %{conn: conn} do
      conn =
        get(conn, Routes.offer_path(conn, :index), %{
          "city" => "",
          "course" => "",
          "kind" => "EAD",
          "level" => "",
          "shift" => "",
          "university" => "",
          "prices" => ""
        })

      assert json_response(conn, 200)["data"] ==
               Offers.filter(
                 %{
                   kind: "ead",
                   level: "",
                   university: "",
                   shift: "",
                   course: "",
                   city: "",
                   prices: ""
                 },
                 CacheOffers.get()
               )
               |> Enum.map(fn data ->
                 %{
                   "full_price" => data.offer.full_price,
                   "price_with_discount" => data.offer.price_with_discount,
                   "discount_percentage" => data.offer.discount_percentage,
                   "start_date" => data.offer.start_date,
                   "enrollment_semester" => data.offer.enrollment_semester,
                   "enabled" => data.offer.enabled,
                   "course" => %{
                     "name" => data.course.name,
                     "kind" => data.course.kind,
                     "level" => data.course.level,
                     "shift" => data.course.shift
                   },
                   "university" => %{
                     "name" => data.university.name,
                     "score" => data.university.score,
                     "logo_url" => data.university.logo_url
                   },
                   "campus" => %{
                     "name" => data.campu.name,
                     "city" => data.campu.city
                   }
                 }
               end)
    end

    test "list offers by level", %{conn: conn} do
      conn =
        get(conn, Routes.offer_path(conn, :index), %{
          "city" => "",
          "course" => "",
          "kind" => "",
          "level" => "Bacharelado",
          "shift" => "",
          "university" => "",
          "prices" => ""
        })

      assert json_response(conn, 200)["data"] ==
               Offers.filter(
                 %{
                   kind: "",
                   level: "bacharelado",
                   university: "",
                   shift: "",
                   course: "",
                   city: "",
                   prices: ""
                 },
                 CacheOffers.get()
               )
               |> Enum.map(fn data ->
                 %{
                   "full_price" => data.offer.full_price,
                   "price_with_discount" => data.offer.price_with_discount,
                   "discount_percentage" => data.offer.discount_percentage,
                   "start_date" => data.offer.start_date,
                   "enrollment_semester" => data.offer.enrollment_semester,
                   "enabled" => data.offer.enabled,
                   "course" => %{
                     "name" => data.course.name,
                     "kind" => data.course.kind,
                     "level" => data.course.level,
                     "shift" => data.course.shift
                   },
                   "university" => %{
                     "name" => data.university.name,
                     "score" => data.university.score,
                     "logo_url" => data.university.logo_url
                   },
                   "campus" => %{
                     "name" => data.campu.name,
                     "city" => data.campu.city
                   }
                 }
               end)
    end

    test "list offers by shift", %{conn: conn} do
      conn =
        get(conn, Routes.offer_path(conn, :index), %{
          "city" => "",
          "course" => "",
          "kind" => "",
          "level" => "",
          "shift" => "Manhã",
          "university" => "",
          "prices" => ""
        })

      assert json_response(conn, 200)["data"] ==
               Offers.filter(
                 %{
                   kind: "",
                   level: "",
                   university: "",
                   shift: "manha",
                   course: "",
                   city: "",
                   prices: ""
                 },
                 CacheOffers.get()
               )
               |> Enum.map(fn data ->
                 %{
                   "full_price" => data.offer.full_price,
                   "price_with_discount" => data.offer.price_with_discount,
                   "discount_percentage" => data.offer.discount_percentage,
                   "start_date" => data.offer.start_date,
                   "enrollment_semester" => data.offer.enrollment_semester,
                   "enabled" => data.offer.enabled,
                   "course" => %{
                     "name" => data.course.name,
                     "kind" => data.course.kind,
                     "level" => data.course.level,
                     "shift" => data.course.shift
                   },
                   "university" => %{
                     "name" => data.university.name,
                     "score" => data.university.score,
                     "logo_url" => data.university.logo_url
                   },
                   "campus" => %{
                     "name" => data.campu.name,
                     "city" => data.campu.city
                   }
                 }
               end)
    end

    test "list offers by prices maior", %{conn: conn} do
      conn =
        get(conn, Routes.offer_path(conn, :index), %{
          "city" => "",
          "course" => "",
          "kind" => "",
          "level" => "",
          "shift" => "",
          "university" => "",
          "prices" => "menor"
        })

      assert json_response(conn, 200)["data"] ==
               Offers.filter(
                 %{
                   kind: "",
                   level: "",
                   university: "",
                   shift: "",
                   course: "",
                   city: "",
                   prices: "menor"
                 },
                 CacheOffers.get()
               )
               |> Enum.map(fn data ->
                 %{
                   "full_price" => data.offer.full_price,
                   "price_with_discount" => data.offer.price_with_discount,
                   "discount_percentage" => data.offer.discount_percentage,
                   "start_date" => data.offer.start_date,
                   "enrollment_semester" => data.offer.enrollment_semester,
                   "enabled" => data.offer.enabled,
                   "course" => %{
                     "name" => data.course.name,
                     "kind" => data.course.kind,
                     "level" => data.course.level,
                     "shift" => data.course.shift
                   },
                   "university" => %{
                     "name" => data.university.name,
                     "score" => data.university.score,
                     "logo_url" => data.university.logo_url
                   },
                   "campus" => %{
                     "name" => data.campu.name,
                     "city" => data.campu.city
                   }
                 }
               end)
    end

    test "list courses by all parameters", %{conn: conn} do
      conn =
        get(conn, Routes.offer_path(conn, :index), %{
          "city" => "sao paulo",
          "course" => "propaganda  e marketing",
          "kind" => "Presencial",
          "level" => "Bacharelado",
          "shift" => "noite",
          "university" => "unip",
          "prices" => "maior"
        })

      assert json_response(conn, 200)["data"] ==
               Offers.filter(
                 %{
                   kind: "presencial",
                   level: "bacharelado",
                   university: "unip",
                   shift: "noite",
                   course: "Propaganda e Marketing",
                   city: "sao paulo",
                   prices: "maior"
                 },
                 CacheOffers.get()
               )
               |> Enum.map(fn data ->
                 %{
                   "full_price" => data.offer.full_price,
                   "price_with_discount" => data.offer.price_with_discount,
                   "discount_percentage" => data.offer.discount_percentage,
                   "start_date" => data.offer.start_date,
                   "enrollment_semester" => data.offer.enrollment_semester,
                   "enabled" => data.offer.enabled,
                   "course" => %{
                     "name" => data.course.name,
                     "kind" => data.course.kind,
                     "level" => data.course.level,
                     "shift" => data.course.shift
                   },
                   "university" => %{
                     "name" => data.university.name,
                     "score" => data.university.score,
                     "logo_url" => data.university.logo_url
                   },
                   "campus" => %{
                     "name" => data.campu.name,
                     "city" => data.campu.city
                   }
                 }
               end)
    end
  end
end
