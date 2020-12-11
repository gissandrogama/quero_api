defmodule QueroApi.Repo.Migrations.CreateCampus do
  use Ecto.Migration

  def change do
    create table(:campus) do
      add :name, :string
      add :city, :string

      add :university_id,
          references(:universities, on_delete: :nilify_all, on_update: :nilify_all)

      timestamps()
    end

    create(unique_index(:campus, [:name]))
  end
end
