defmodule QueroApi.Repo.Migrations.CreateOffers do
  use Ecto.Migration

  def change do
    create table(:offers) do
      add :full_price, :float
      add :price_with_discount, :float
      add :discount_percentage, :float
      add :start_date, :string
      add :enrollment_semester, :string
      add :enabled, :boolean, default: false, null: false
      add :course_id, references(:courses, on_delete: :nilify_all, on_update: :nilify_all)

      timestamps()
    end

    create index(:offers, [:course_id])
  end
end
