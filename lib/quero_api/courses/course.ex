defmodule QueroApi.Courses.Course do
  @moduledoc """
  this is a schema **courses** module with the function to verify data integrity
  """

  use Ecto.Schema
  import Ecto.Changeset
  @derive {Jason.Encoder, only: [:kind, :level, :name, :shift]}

  alias QueroApi.{Campus, CampusCourses, CoursesOffers}
  alias QueroApi.Offers.Offer

  schema "courses" do
    field :kind, :string
    field :level, :string
    field :name, :string
    field :shift, :string

    many_to_many :campus, Campus.Campu, join_through: CampusCourses.CampusCourse

    many_to_many :offers, Offer,
      join_through: CoursesOffers.CoursesOffer,
      on_replace: :mark_as_invalid

    timestamps()
  end

  @doc false
  def changeset(course, attrs) do
    course
    |> cast(attrs, [:name, :kind, :level, :shift])
    |> unsafe_validate_unique([:name, :kind, :shift], QueroApi.Repo)
    |> unique_constraint([:name, :kind, :shift])
    |> cast_assoc(:offers, with: &Offer.changeset/2)
    |> validate_required([:name, :kind, :level, :shift])
  end
end
