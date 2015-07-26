defmodule PhoenixTours.Repo.Migrations.CreateTour do
  use Ecto.Migration

  def change do
    create table(:tours) do
      add :title, :string
      add :description, :text
      add :published, :boolean, default: false
      add :city_id, references(:cities)

      timestamps
    end

    create table(:tours_categories) do
      add :tour_id, references(:tours)
      add :category_id, references(:categories)
    end
  end
end
