defmodule PhoenixTours.Repo.Migrations.ChangeToursCategories do
  use Ecto.Migration

  def change do
    execute "ALTER TABLE tours_categories RENAME to tour_categories"

    execute "ALTER TABLE tour_categories
             DROP CONSTRAINT tours_categories_category_id_fkey,
             ADD CONSTRAINT tour_categories_category_id_fkey
               FOREIGN KEY (category_id)
               REFERENCES categories(id)
               ON DELETE CASCADE"

     execute "ALTER TABLE tour_categories
              DROP CONSTRAINT tours_categories_tour_id_fkey,
              ADD CONSTRAINT tour_categories_tour_id_fkey
                FOREIGN KEY (tour_id)
                REFERENCES tours(id)
                ON DELETE CASCADE"
  end
end
