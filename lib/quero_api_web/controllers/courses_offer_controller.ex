defmodule QueroApiWeb.CoursesOfferController do
  use QueroApiWeb, :controller

  alias QueroApi.CoursesOffers
  alias QueroApi.CoursesOffers.CoursesOffer

  action_fallback QueroApiWeb.FallbackController

  def index(conn, _params) do
    courses_offers = CoursesOffers.list_courses_offers()
    render(conn, "index.json", courses_offers: courses_offers)
  end

  def create(conn, %{"courses_offer" => courses_offer_params}) do
    with {:ok, %CoursesOffer{} = courses_offer} <- CoursesOffers.create_courses_offer(courses_offer_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.courses_offer_path(conn, :show, courses_offer))
      |> render("show.json", courses_offer: courses_offer)
    end
  end

  def show(conn, %{"id" => id}) do
    courses_offer = CoursesOffers.get_courses_offer!(id)
    render(conn, "show.json", courses_offer: courses_offer)
  end

  def update(conn, %{"id" => id, "courses_offer" => courses_offer_params}) do
    courses_offer = CoursesOffers.get_courses_offer!(id)

    with {:ok, %CoursesOffer{} = courses_offer} <- CoursesOffers.update_courses_offer(courses_offer, courses_offer_params) do
      render(conn, "show.json", courses_offer: courses_offer)
    end
  end

  def delete(conn, %{"id" => id}) do
    courses_offer = CoursesOffers.get_courses_offer!(id)

    with {:ok, %CoursesOffer{}} <- CoursesOffers.delete_courses_offer(courses_offer) do
      send_resp(conn, :no_content, "")
    end
  end
end
