defmodule PhoenixTours.CityController do
  use PhoenixTours.Web, :controller

  alias PhoenixTours.City

  def index(conn, _params) do
    cities = Repo.all(City)
    render(conn, "index.html", cities: cities)
  end

  def show(conn, %{"id" => id}) do
    city = Repo.get!(City, id)
    render(conn, "show.html", city: city)
  end
end
