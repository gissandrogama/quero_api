defmodule QueroApi.Campus.Campu do
  use Ecto.Schema
  import Ecto.Changeset

  schema "campus" do
    field :city, :string
    field :name, :string
    field :university_id, :id

    timestamps()
  end

  @doc false
  def changeset(campu, attrs) do
    campu
    |> cast(attrs, [:name, :city])
    |> validate_required([:name, :city])
  end
end
