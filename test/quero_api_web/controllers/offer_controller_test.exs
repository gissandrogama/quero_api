defmodule QueroApiWeb.OfferControllerTest do
  use QueroApiWeb.ConnCase, async: true

  import QueroApiWeb.UserAurh
  import QueroApi.FixturesAll

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

      assert json_response(conn, 200)["data"] == []
    end

    test "lists all offers", %{conn: conn} do
      university = university_fixture()
      offer = offers_fixture()
      campu = campus_fixture(%{university_id: university.id})
      course = courses_fixture()

      campus_courses_fixture(%{campu_id: campu.id, course_id: course.id})
      offers_courses_fixture(%{offer_id: offer.id, course_id: course.id})

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

      assert json_response(conn, 200)["data"] == [
               %{
                 "full_price" => offer.full_price,
                 "price_with_discount" => offer.price_with_discount,
                 "discount_percentage" => offer.discount_percentage,
                 "start_date" => offer.start_date,
                 "enrollment_semester" => offer.enrollment_semester,
                 "enabled" => offer.enabled,
                 "course" => %{
                   "name" => course.name,
                   "kind" => course.kind,
                   "level" => course.level,
                   "shift" => course.shift
                 },
                 "university" => %{
                   "name" => university.name,
                   "score" => university.score,
                   "logo_url" => university.logo_url
                 },
                 "campus" => %{
                   "name" => campu.name,
                   "city" => campu.city
                 }
               }
             ]
    end

    test "list offers by university name", %{conn: conn} do
      university = university_fixture(%{name: "UNAMA"})
      offer = offers_fixture()
      campu = campus_fixture(%{university_id: university.id})
      course = courses_fixture()

      campus_courses_fixture(%{campu_id: campu.id, course_id: course.id})
      offers_courses_fixture(%{offer_id: offer.id, course_id: course.id})

      university2 = university_fixture(%{name: "Estácio"})
      offer2 = offers_fixture()
      campu2 = campus_fixture(%{university_id: university2.id})
      course2 = courses_fixture()

      campus_courses_fixture(%{campu_id: campu2.id, course_id: course2.id})
      offers_courses_fixture(%{offer_id: offer2.id, course_id: course2.id})

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

      assert json_response(conn, 200)["data"] == [
               %{
                 "full_price" => offer.full_price,
                 "price_with_discount" => offer.price_with_discount,
                 "discount_percentage" => offer.discount_percentage,
                 "start_date" => offer.start_date,
                 "enrollment_semester" => offer.enrollment_semester,
                 "enabled" => offer.enabled,
                 "course" => %{
                   "name" => course.name,
                   "kind" => course.kind,
                   "level" => course.level,
                   "shift" => course.shift
                 },
                 "university" => %{
                   "name" => university.name,
                   "score" => university.score,
                   "logo_url" => university.logo_url
                 },
                 "campus" => %{
                   "name" => campu.name,
                   "city" => campu.city
                 }
               }
             ]
    end

    test "list offers by course name", %{conn: conn} do
      university = university_fixture()
      offer = offers_fixture()
      campu = campus_fixture(%{university_id: university.id})
      course = courses_fixture(%{name: "Sistema de informação"})

      campus_courses_fixture(%{campu_id: campu.id, course_id: course.id})
      offers_courses_fixture(%{offer_id: offer.id, course_id: course.id})

      university2 = university_fixture()
      offer2 = offers_fixture()
      campu2 = campus_fixture(%{university_id: university2.id})
      course2 = courses_fixture(%{name: "Administração"})

      campus_courses_fixture(%{campu_id: campu2.id, course_id: course2.id})
      offers_courses_fixture(%{offer_id: offer2.id, course_id: course2.id})

      conn =
        get(conn, Routes.offer_path(conn, :index), %{
          "city" => "",
          "course" => "Sistema de informação",
          "kind" => "",
          "level" => "",
          "shift" => "",
          "university" => "",
          "prices" => ""
        })

      assert json_response(conn, 200)["data"] == [
               %{
                 "full_price" => offer.full_price,
                 "price_with_discount" => offer.price_with_discount,
                 "discount_percentage" => offer.discount_percentage,
                 "start_date" => offer.start_date,
                 "enrollment_semester" => offer.enrollment_semester,
                 "enabled" => offer.enabled,
                 "course" => %{
                   "name" => course.name,
                   "kind" => course.kind,
                   "level" => course.level,
                   "shift" => course.shift
                 },
                 "university" => %{
                   "name" => university.name,
                   "score" => university.score,
                   "logo_url" => university.logo_url
                 },
                 "campus" => %{
                   "name" => campu.name,
                   "city" => campu.city
                 }
               }
             ]
    end

    test "list offers by city name", %{conn: conn} do
      university = university_fixture()
      offer = offers_fixture()
      campu = campus_fixture(%{city: "Belém", university_id: university.id})
      course = courses_fixture()

      campus_courses_fixture(%{campu_id: campu.id, course_id: course.id})
      offers_courses_fixture(%{offer_id: offer.id, course_id: course.id})

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

      assert json_response(conn, 200)["data"] == [
               %{
                 "full_price" => offer.full_price,
                 "price_with_discount" => offer.price_with_discount,
                 "discount_percentage" => offer.discount_percentage,
                 "start_date" => offer.start_date,
                 "enrollment_semester" => offer.enrollment_semester,
                 "enabled" => offer.enabled,
                 "course" => %{
                   "name" => course.name,
                   "kind" => course.kind,
                   "level" => course.level,
                   "shift" => course.shift
                 },
                 "university" => %{
                   "name" => university.name,
                   "score" => university.score,
                   "logo_url" => university.logo_url
                 },
                 "campus" => %{
                   "name" => campu.name,
                   "city" => campu.city
                 }
               }
             ]
    end

    test "list offers by kind", %{conn: conn} do
      university = university_fixture()
      offer = offers_fixture()
      campu = campus_fixture(%{university_id: university.id})
      course = courses_fixture(%{kind: "EAD"})

      campus_courses_fixture(%{campu_id: campu.id, course_id: course.id})
      offers_courses_fixture(%{offer_id: offer.id, course_id: course.id})

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

      assert json_response(conn, 200)["data"] == [
               %{
                 "full_price" => offer.full_price,
                 "price_with_discount" => offer.price_with_discount,
                 "discount_percentage" => offer.discount_percentage,
                 "start_date" => offer.start_date,
                 "enrollment_semester" => offer.enrollment_semester,
                 "enabled" => offer.enabled,
                 "course" => %{
                   "name" => course.name,
                   "kind" => course.kind,
                   "level" => course.level,
                   "shift" => course.shift
                 },
                 "university" => %{
                   "name" => university.name,
                   "score" => university.score,
                   "logo_url" => university.logo_url
                 },
                 "campus" => %{
                   "name" => campu.name,
                   "city" => campu.city
                 }
               }
             ]
    end

    test "list offers by level", %{conn: conn} do
      university = university_fixture()
      offer = offers_fixture()
      campu = campus_fixture(%{university_id: university.id})
      course = courses_fixture(%{level: "Bacharelado"})

      campus_courses_fixture(%{campu_id: campu.id, course_id: course.id})
      offers_courses_fixture(%{offer_id: offer.id, course_id: course.id})

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

      assert json_response(conn, 200)["data"] == [
               %{
                 "full_price" => offer.full_price,
                 "price_with_discount" => offer.price_with_discount,
                 "discount_percentage" => offer.discount_percentage,
                 "start_date" => offer.start_date,
                 "enrollment_semester" => offer.enrollment_semester,
                 "enabled" => offer.enabled,
                 "course" => %{
                   "name" => course.name,
                   "kind" => course.kind,
                   "level" => course.level,
                   "shift" => course.shift
                 },
                 "university" => %{
                   "name" => university.name,
                   "score" => university.score,
                   "logo_url" => university.logo_url
                 },
                 "campus" => %{
                   "name" => campu.name,
                   "city" => campu.city
                 }
               }
             ]
    end

    test "list offers by shift", %{conn: conn} do
      university = university_fixture()
      offer = offers_fixture()
      campu = campus_fixture(%{university_id: university.id})
      course = courses_fixture(%{shift: "Manhã"})

      campus_courses_fixture(%{campu_id: campu.id, course_id: course.id})
      offers_courses_fixture(%{offer_id: offer.id, course_id: course.id})

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

      assert json_response(conn, 200)["data"] == [
               %{
                 "full_price" => offer.full_price,
                 "price_with_discount" => offer.price_with_discount,
                 "discount_percentage" => offer.discount_percentage,
                 "start_date" => offer.start_date,
                 "enrollment_semester" => offer.enrollment_semester,
                 "enabled" => offer.enabled,
                 "course" => %{
                   "name" => course.name,
                   "kind" => course.kind,
                   "level" => course.level,
                   "shift" => course.shift
                 },
                 "university" => %{
                   "name" => university.name,
                   "score" => university.score,
                   "logo_url" => university.logo_url
                 },
                 "campus" => %{
                   "name" => campu.name,
                   "city" => campu.city
                 }
               }
             ]
    end

    test "list offers by prices maior", %{conn: conn} do
      university = university_fixture(%{name: "UNAMA"})
      offer = offers_fixture(%{price_with_discount: "800.65"})
      campu = campus_fixture(%{university_id: university.id})
      course = courses_fixture()

      campus_courses_fixture(%{campu_id: campu.id, course_id: course.id})
      offers_courses_fixture(%{offer_id: offer.id, course_id: course.id})

      university2 = university_fixture(%{name: "Estácio"})
      offer2 = offers_fixture(%{price_with_discount: "600.65"})
      campu2 = campus_fixture(%{university_id: university2.id})
      course2 = courses_fixture()

      campus_courses_fixture(%{campu_id: campu2.id, course_id: course2.id})
      offers_courses_fixture(%{offer_id: offer2.id, course_id: course2.id})

      conn =
        get(conn, Routes.offer_path(conn, :index), %{
          "city" => "",
          "course" => "",
          "kind" => "",
          "level" => "",
          "shift" => "",
          "university" => "",
          "prices" => "maior"
        })

      assert json_response(conn, 200)["data"] == [
               %{
                 "full_price" => offer.full_price,
                 "price_with_discount" => offer.price_with_discount,
                 "discount_percentage" => offer.discount_percentage,
                 "start_date" => offer.start_date,
                 "enrollment_semester" => offer.enrollment_semester,
                 "enabled" => offer.enabled,
                 "course" => %{
                   "name" => course.name,
                   "kind" => course.kind,
                   "level" => course.level,
                   "shift" => course.shift
                 },
                 "university" => %{
                   "name" => university.name,
                   "score" => university.score,
                   "logo_url" => university.logo_url
                 },
                 "campus" => %{
                   "name" => campu.name,
                   "city" => campu.city
                 }
               },
               %{
                 "full_price" => offer2.full_price,
                 "price_with_discount" => offer2.price_with_discount,
                 "discount_percentage" => offer2.discount_percentage,
                 "start_date" => offer2.start_date,
                 "enrollment_semester" => offer2.enrollment_semester,
                 "enabled" => offer2.enabled,
                 "course" => %{
                   "name" => course2.name,
                   "kind" => course2.kind,
                   "level" => course2.level,
                   "shift" => course2.shift
                 },
                 "university" => %{
                   "name" => university2.name,
                   "score" => university2.score,
                   "logo_url" => university2.logo_url
                 },
                 "campus" => %{
                   "name" => campu2.name,
                   "city" => campu2.city
                 }
               }
             ]
    end

    test "list courses by all parameters", %{conn: conn} do
      university = university_fixture(%{name: "UNAMA"})
      offer = offers_fixture(%{price_with_discount: "800.65"})
      campu = campus_fixture(%{name: "Belém", city: "Belém", university_id: university.id})

      course =
        courses_fixture(%{
          name: "Farmácia",
          kind: "Presencial",
          level: "Bacharelado",
          shift: "Manhã"
        })

      campus_courses_fixture(%{campu_id: campu.id, course_id: course.id})
      offers_courses_fixture(%{offer_id: offer.id, course_id: course.id})

      university2 = university_fixture(%{name: "Estácio"})
      offer2 = offers_fixture(%{price_with_discount: "600.65"})

      campu2 =
        campus_fixture(%{name: "Campus Belém", city: "Belém", university_id: university2.id})

      course2 =
        courses_fixture(%{
          name: "Arquitetura e Urbanismo",
          kind: "Presencial",
          level: "Bacharelado",
          shift: "Noite"
        })

      campus_courses_fixture(%{campu_id: campu2.id, course_id: course2.id})
      offers_courses_fixture(%{offer_id: offer2.id, course_id: course2.id})

      conn =
        get(conn, Routes.offer_path(conn, :index), %{
          "city" => "Belém",
          "course" => "Farmácia",
          "kind" => "Presencial",
          "level" => "Bacharelado",
          "shift" => "Manhã",
          "university" => "UNAMA",
          "prices" => ""
        })

      assert json_response(conn, 200)["data"] == [
               %{
                 "full_price" => offer.full_price,
                 "price_with_discount" => offer.price_with_discount,
                 "discount_percentage" => offer.discount_percentage,
                 "start_date" => offer.start_date,
                 "enrollment_semester" => offer.enrollment_semester,
                 "enabled" => offer.enabled,
                 "course" => %{
                   "name" => course.name,
                   "kind" => course.kind,
                   "level" => course.level,
                   "shift" => course.shift
                 },
                 "university" => %{
                   "name" => university.name,
                   "score" => university.score,
                   "logo_url" => university.logo_url
                 },
                 "campus" => %{
                   "name" => campu.name,
                   "city" => campu.city
                 }
               }
             ]
    end

    test "list offers by prices menor", %{conn: conn} do
      university = university_fixture(%{name: "UNAMA"})
      offer = offers_fixture(%{price_with_discount: "800.65"})
      campu = campus_fixture(%{university_id: university.id})
      course = courses_fixture()

      campus_courses_fixture(%{campu_id: campu.id, course_id: course.id})
      offers_courses_fixture(%{offer_id: offer.id, course_id: course.id})

      university2 = university_fixture(%{name: "Estácio"})
      offer2 = offers_fixture(%{price_with_discount: "600.65"})
      campu2 = campus_fixture(%{university_id: university2.id})
      course2 = courses_fixture()

      campus_courses_fixture(%{campu_id: campu2.id, course_id: course2.id})
      offers_courses_fixture(%{offer_id: offer2.id, course_id: course2.id})

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

      assert json_response(conn, 200)["data"] == [
               %{
                 "full_price" => offer2.full_price,
                 "price_with_discount" => offer2.price_with_discount,
                 "discount_percentage" => offer2.discount_percentage,
                 "start_date" => offer2.start_date,
                 "enrollment_semester" => offer2.enrollment_semester,
                 "enabled" => offer2.enabled,
                 "course" => %{
                   "name" => course2.name,
                   "kind" => course2.kind,
                   "level" => course2.level,
                   "shift" => course2.shift
                 },
                 "university" => %{
                   "name" => university2.name,
                   "score" => university2.score,
                   "logo_url" => university2.logo_url
                 },
                 "campus" => %{
                   "name" => campu2.name,
                   "city" => campu2.city
                 }
               },
               %{
                 "full_price" => offer.full_price,
                 "price_with_discount" => offer.price_with_discount,
                 "discount_percentage" => offer.discount_percentage,
                 "start_date" => offer.start_date,
                 "enrollment_semester" => offer.enrollment_semester,
                 "enabled" => offer.enabled,
                 "course" => %{
                   "name" => course.name,
                   "kind" => course.kind,
                   "level" => course.level,
                   "shift" => course.shift
                 },
                 "university" => %{
                   "name" => university.name,
                   "score" => university.score,
                   "logo_url" => university.logo_url
                 },
                 "campus" => %{
                   "name" => campu.name,
                   "city" => campu.city
                 }
               }
             ]
    end
  end

  # describe "create offer" do
  #   test "renders offer when data is valid", %{conn: conn} do
  #     conn = post(conn, Routes.offer_path(conn, :create), offer: @create_attrs)
  #     assert %{"id" => id} = json_response(conn, 201)["data"]

  #     conn = get(conn, Routes.offer_path(conn, :show, id))

  #     assert %{
  #              "id" => id,
  #              "discount_percentage" => 120.5,
  #              "enabled" => true,
  #              "enrollment_semester" => "some enrollment_semester",
  #              "full_price" => 120.5,
  #              "price_with_discount" => 120.5,
  #              "start_date" => "some start_date"
  #            } = json_response(conn, 200)["data"]
  #   end

  #   test "renders errors when data is invalid", %{conn: conn} do
  #     conn = post(conn, Routes.offer_path(conn, :create), offer: @invalid_attrs)
  #     assert json_response(conn, 422)["errors"] != %{}
  #   end
  # end

  # describe "update offer" do
  #   setup [:create_offer]

  #   test "renders offer when data is valid", %{conn: conn, offer: %Offer{id: id} = offer} do
  #     conn = put(conn, Routes.offer_path(conn, :update, offer), offer: @update_attrs)
  #     assert %{"id" => ^id} = json_response(conn, 200)["data"]

  #     conn = get(conn, Routes.offer_path(conn, :show, id))

  #     assert %{
  #              "id" => id,
  #              "discount_percentage" => 456.7,
  #              "enabled" => false,
  #              "enrollment_semester" => "some updated enrollment_semester",
  #              "full_price" => 456.7,
  #              "price_with_discount" => 456.7,
  #              "start_date" => "some updated start_date"
  #            } = json_response(conn, 200)["data"]
  #   end

  #   test "renders errors when data is invalid", %{conn: conn, offer: offer} do
  #     conn = put(conn, Routes.offer_path(conn, :update, offer), offer: @invalid_attrs)
  #     assert json_response(conn, 422)["errors"] != %{}
  #   end
  # end

  # describe "delete offer" do
  #   setup [:create_offer]

  #   test "deletes chosen offer", %{conn: conn, offer: offer} do
  #     conn = delete(conn, Routes.offer_path(conn, :delete, offer))
  #     assert response(conn, 204)

  #     assert_error_sent 404, fn ->
  #       get(conn, Routes.offer_path(conn, :show, offer))
  #     end
  #   end
  # end

  # defp create_offer(_) do
  #   offer = fixture(:offer)
  #   %{offer: offer}
  # end
end
