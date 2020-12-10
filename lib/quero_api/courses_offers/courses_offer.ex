defmodule QueroApi.CoursesOffers.CoursesOffer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "courses_offers" do
    belongs_to :course, QueroApi.Courses.Course
    belongs_to :offer, QueroApi.Offers.Offer

    timestamps()
  end

  @doc false
  def changeset(courses_offer, attrs) do
    courses_offer
    |> cast(attrs, [:course_id, :offer_id])
    |> foreign_key_constraint(:course_id)
    |> foreign_key_constraint(:offer_id)
    |> validate_required([:course_id, :offer_id])
  end
end
