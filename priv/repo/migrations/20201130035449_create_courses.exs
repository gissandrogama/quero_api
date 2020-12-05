defmodule QueroApi.Repo.Migrations.CreateCourses do
  use Ecto.Migration

  def change do
    create table(:courses) do
      add :name, :string
      add :kind, :string
      add :level, :string
      add :shift, :string

      timestamps()
    end
  end
end
