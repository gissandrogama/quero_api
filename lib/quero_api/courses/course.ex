defmodule QueroApi.Courses.Course do
  use Ecto.Schema
  import Ecto.Changeset

  schema "courses" do
    field :kind, :string
    field :level, :string
    field :name, :string
    field :shift, :string

    belongs_to :campu, QueroApi.Campus.Campu
    has_one :offers, QueroApi.Offers.Offer

    timestamps()
  end

  @doc false
  def changeset(course, attrs) do
    course
    |> cast(attrs, [:name, :kind, :level, :shift])
    |> validate_required([:name, :kind, :level, :shift])
  end
end
