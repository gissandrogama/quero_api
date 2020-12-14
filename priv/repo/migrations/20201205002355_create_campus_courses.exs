defmodule QueroApi.Repo.Migrations.CreateCampusCourses do
  use Ecto.Migration

  def change do
    create table(:campus_courses) do
      add :campu_id, references(:campus, on_delete: :nilify_all, on_update: :nilify_all)
      add :course_id, references(:courses, on_delete: :nilify_all, on_update: :nilify_all)

      timestamps()
    end

    create(unique_index(:campus_courses, [:campu_id, :course_id]))
  end
end
