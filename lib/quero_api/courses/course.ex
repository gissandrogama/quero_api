defmodule QueroApi.Courses.Course do
  use Ecto.Schema
  import Ecto.Changeset

  schema "courses" do
    field :kind, :string
    field :level, :string
    field :name, :string
    field :shift, :string
    field :campu_id, :id

    timestamps()
  end

  @doc false
  def changeset(course, attrs) do
    course
    |> cast(attrs, [:name, :kind, :level, :shift])
    |> validate_required([:name, :kind, :level, :shift])
  end
end
