defmodule PhoenixTours.TourView do
  use PhoenixTours.Web, :view
  import Ecto.Query

  alias PhoenixTours.Category
  alias PhoenixTours.Repo

  def categories do
    Repo.all from c in Category, order_by: c.name
  end
end
