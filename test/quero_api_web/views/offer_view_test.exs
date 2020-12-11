defmodule QueroApi.OfferViewTest do
  use QueroApi.DataCase, async: true

  import QueroApi.FixturesAll

  alias QueroApiWeb.OfferView

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

      offer =
        offers_fixture(%{
          full_price: 1408.63,
          price_with_discount: 493.02,
          discount_percentage: 65.0,
          start_date: "01/02/2020",
          enrollment_semester: "2020.1",
          enabled: true
        })

      campu = campus_fixture(%{name: "Belém", city: "Belém", university_id: university.id})

      offers_courses_fixture(%{course_id: course.id, offer_id: offer.id})

      campus_courses_fixture(%{campu_id: campu.id, course_id: course.id})

      offers = [[offer: offer, course: course, university: university, campus: campu]]

      assert %{
               data: [
                 %{
                   full_price: 1408.63,
                   price_with_discount: 493.02,
                   discount_percentage: 65.0,
                   start_date: "01/02/2020",
                   enrollment_semester: "2020.1",
                   enabled: true,
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
             } =~ OfferView.render("index.json", %{offers: offers})
    end
  end
end
