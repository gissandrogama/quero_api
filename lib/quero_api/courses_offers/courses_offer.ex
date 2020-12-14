defmodule QueroApi.CoursesOffers.CoursesOffer do
  @moduledoc """
  this is a schema **courses_offers** module with the function to verify data integrity
  """
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
    |> validate_required([:course_id, :offer_id])
  end
end
