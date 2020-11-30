defmodule QueroApi.Campus.Campu do
  use Ecto.Schema
  import Ecto.Changeset

  schema "campus" do
    field :city, :string
    field :name, :string

    belongs_to :university, QueroApi.Universities.University
    has_many :courses, QueroApi.Courses.Course

    timestamps()
  end

  @doc false
  def changeset(campu, attrs) do
    campu
    |> cast(attrs, [:name, :city])
    |> validate_required([:name, :city])
  end
end
