defmodule PhoenixTours.CategoryController do
  use PhoenixTours.Web, :controller

  alias PhoenixTours.Category

  def show(conn, %{"id" => id}) do
    category = Repo.get!(Category, id) |> Repo.preload([:tours])
    render(conn, "show.html", category: category)
  end
end
