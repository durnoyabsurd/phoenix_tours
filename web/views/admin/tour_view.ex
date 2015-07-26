defmodule PhoenixTours.Admin.TourView do
  use PhoenixTours.Web, :view

  alias PhoenixTours.City
  alias PhoenixTours.Category
  alias PhoenixTours.Repo
  import Ecto.Query

  def city_options do
    Repo.all from c in City, select: {c.name, c.id}, order_by: c.name
  end

  def categories_options do
    Repo.all from c in Category, select: {c.name, c.id}, order_by: c.name
  end
end
