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
    belongs_to :course, QueroApi.Courses.Course

    timestamps()
  end

  @doc false
  def changeset(offer, attrs) do
    offer
    |> cast(attrs, [:full_price, :price_with_discount, :discount_percentage, :start_date, :enrollment_semester, :enabled])
    |> validate_required([:full_price, :price_with_discount, :discount_percentage, :start_date, :enrollment_semester, :enabled])
  end
end
