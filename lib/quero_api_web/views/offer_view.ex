defmodule QueroApiWeb.OfferView do
  use QueroApiWeb, :view
  alias QueroApiWeb.OfferView

  def render("index.json", %{offers: offers}) do
    %{data: render_many(offers, OfferView, "offer.json")}
  end

  def render("show.json", %{offer: offer}) do
    %{data: render_one(offer, OfferView, "offer.json")}
  end

  def render("offer.json", %{offer: offer}) do
    offer = Enum.into(offer, %{})

    %{
      full_price: offer.offer.full_price,
      price_with_discount: offer.offer.price_with_discount,
      discount_percentage: offer.offer.discount_percentage,
      start_date: offer.offer.start_date,
      enrollment_semester: offer.offer.enrollment_semester,
      enabled: offer.offer.enabled,
      course: %{
        name: offer.course.name,
        kind: offer.course.kind,
        level: offer.course.level,
        shift: offer.course.shift
      },
      university: %{
        name: offer.university.name,
        score: offer.university.score,
        logo_url: offer.university.logo_url
      },
      campus: %{
        name: offer.campus.name,
        city: offer.campus.city
      }
    }
  end
end
