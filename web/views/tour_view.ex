defmodule PhoenixTours.TourView do
  use PhoenixTours.Web, :view
  import Ecto.Query

  alias PhoenixTours.Category
  alias PhoenixTours.City
  alias PhoenixTours.Repo

  def categories do
    Repo.all from c in Category, order_by: c.name
  end

  def cities do
    Repo.all from c in City, order_by: c.name
  end
end
