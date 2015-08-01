defmodule PhoenixTours.Admin.TourView do
  use PhoenixTours.Web, :view
  import Ecto.Query

  alias PhoenixTours.City
  alias PhoenixTours.Category
  alias PhoenixTours.Repo

  def city_options do
    Repo.all from c in City, select: {c.name, c.id}, order_by: c.name
  end

  def categories_options do
    Repo.all from c in Category, select: {c.name, c.id}, order_by: c.name
  end

  def category_ids(changeset) do
    cond do
      changeset.params ->
        changeset.params["category_ids"]
      changeset.model.id ->
        changeset.model.tour_categories
        |> Enum.map(fn(x) -> x.category_id end)
      true -> []
    end
  end
end
