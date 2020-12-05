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

      timestamps()
    end
  end
end
