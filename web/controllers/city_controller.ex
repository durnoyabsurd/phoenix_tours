defmodule PhoenixTours.CityController do
  use PhoenixTours.Web, :controller

  alias PhoenixTours.City

  def index(conn, _params) do
    cities = Repo.all from c in City, order_by: c.name
    render(conn, "index.html", cities: cities)
  end

  def show(conn, %{"id" => id}) do
    city = Repo.get!(City, id) |> Repo.preload([:tours])
    render(conn, "show.html", city: city)
  end
end
