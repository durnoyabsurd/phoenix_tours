defmodule PhoenixTours.CategoryController do
  use PhoenixTours.Web, :controller

  alias PhoenixTours.Category
  
  def index(conn, _params) do
    categories = Repo.all(Category)
    render(conn, "index.html", categories: categories)
  end
end
