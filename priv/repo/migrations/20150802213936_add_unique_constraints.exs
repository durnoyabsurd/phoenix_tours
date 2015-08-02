defmodule PhoenixTours.Repo.Migrations.AddUniqueConstraints do
  use Ecto.Migration

  def change do
    execute "CREATE UNIQUE INDEX categories_name_idx ON categories (name)"
    execute "CREATE UNIQUE INDEX cities_name_idx ON cities (name)"
    execute "CREATE UNIQUE INDEX tours_title_idx ON tours (title)"
  end
end
