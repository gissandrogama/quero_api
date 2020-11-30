defmodule QueroApi.Universities.University do
  use Ecto.Schema
  import Ecto.Changeset

  schema "universities" do
    field :logo_url, :string
    field :name, :string
    field :score, :float

    has_many :campus, QueroApi.Campus.Campu

    timestamps()
  end

  @doc false
  def changeset(university, attrs) do
    university
    |> cast(attrs, [:name, :score, :logo_url])
    |> validate_required([:name, :score, :logo_url])
  end
end
