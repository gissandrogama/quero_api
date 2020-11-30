defmodule QueroApi.Repo.Migrations.CreateCampus do
  use Ecto.Migration

  def change do
    create table(:campus) do
      add :name, :string
      add :city, :string
      add :university_id, references(:universities, on_delete: :nothing)

      timestamps()
    end

    create index(:campus, [:university_id])
  end
end
