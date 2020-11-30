defmodule QueroApi.Repo.Migrations.CreateCourses do
  use Ecto.Migration

  def change do
    create table(:courses) do
      add :name, :string
      add :kind, :string
      add :level, :string
      add :shift, :string
      add :campu_id, references(:campus, on_delete: :nothing)

      timestamps()
    end

    create index(:courses, [:campu_id])
  end
end
