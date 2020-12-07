defmodule QueroApi.Offers.Offer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "offers" do
    field :discount_percentage, :float
    field :enabled, :boolean, default: false
    field :enrollment_semester, :string
    field :full_price, :float
    field :price_with_discount, :float
    field :start_date, :string
    many_to_many :courses, QueroApi.Courses.Course, join_through: QueroApi.CoursesOffers.CoursesOffer

    timestamps()
  end

  @doc false
  def changeset(offer, attrs) do
    offer
    |> cast(attrs, [:full_price, :price_with_discount, :discount_percentage, :start_date, :enrollment_semester, :enabled])
    |> unsafe_validate_unique([:full_price, :price_with_discount, :discount_percentage, :start_date, :enrollment_semester, :enabled], QueroApi.Repo)
    |> unique_constraint([:full_price, :price_with_discount, :discount_percentage, :start_date, :enrollment_semester, :enabled])
    |> validate_required([:full_price, :price_with_discount, :discount_percentage, :start_date, :enrollment_semester, :enabled])
  end
end
