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
    %{id: offer.id,
      full_price: offer.full_price,
      price_with_discount: offer.price_with_discount,
      discount_percentage: offer.discount_percentage,
      start_date: offer.start_date,
      enrollment_semester: offer.enrollment_semester,
      enabled: offer.enabled}
  end
end
