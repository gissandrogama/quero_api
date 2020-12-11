defmodule QueroApi.Campus.Campu do
  @moduledoc """
  this is a schema **campus** module with the function to verify data integrity
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias QueroApi.{CampusCourses, Courses, Universities}

  schema "campus" do
    field :city, :string
    field :name, :string

    belongs_to :university, Universities.University
    many_to_many :courses, Courses.Course, join_through: CampusCourses.CampusCourse

    timestamps()
  end

  @doc false
  def changeset(campu, attrs) do
    campu
    |> cast(attrs, [:name, :city, :university_id])
    |> unsafe_validate_unique(:name, QueroApi.Repo)
    |> unique_constraint(:name)
    |> foreign_key_constraint(:university_id)
    |> cast_assoc(:courses, with: &Courses.Course.changeset/2)
    |> validate_required([:name, :city, :courses])
  end
end
