defmodule QueroApi.Repo.Migrations.CreateCoursesOffers do
  use Ecto.Migration

  def change do
    create table(:courses_offers) do
      add :course_id, references(:courses, on_delete: :nilify_all, on_update: :nilify_all)
      add :offer_id, references(:offers, on_delete: :nilify_all, on_update: :nilify_all)

      timestamps()
    end

    create index(:courses_offers, [:course_id])
    create index(:courses_offers, [:offer_id])
  end
end
