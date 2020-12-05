defmodule QueroApiWeb.CoursesOfferView do
  use QueroApiWeb, :view
  alias QueroApiWeb.CoursesOfferView

  def render("index.json", %{courses_offers: courses_offers}) do
    %{data: render_many(courses_offers, CoursesOfferView, "courses_offer.json")}
  end

  def render("show.json", %{courses_offer: courses_offer}) do
    %{data: render_one(courses_offer, CoursesOfferView, "courses_offer.json")}
  end

  def render("courses_offer.json", %{courses_offer: courses_offer}) do
    %{id: courses_offer.id}
  end
end
