defmodule QueroApi.Universities.University do
  use Ecto.Schema
  import Ecto.Changeset

  alias QueroApi.Campus.Campu

  schema "universities" do
    field :logo_url, :string
    field :name, :string
    field :score, :float

    has_many :campus, Campu

    timestamps()
  end

  @doc false
  def changeset(university, attrs) do
    university
    |> cast(attrs, [:name, :score, :logo_url])
    |> unsafe_validate_unique(:name, QueroApi.Repo, message: "universidade já cadastrada")
    |> unique_constraint(:name)
    |> cast_assoc(:campus, with: &Campu.changeset/2)
    |> validate_required([:name, :score, :logo_url, :campus])
  end
end
