defmodule PhoenixTours.CategoryController do
  use PhoenixTours.Web, :controller

  alias PhoenixTours.Category

  def index(conn, _params) do
    categories = Repo.all from c in Category, order_by: c.name
    render(conn, "index.html", categories: categories)
  end

  def show(conn, %{"id" => id}) do
    category = Repo.get!(Category, id) |> Repo.preload([:tours])
    render(conn, "show.html", category: category)
  end
end
