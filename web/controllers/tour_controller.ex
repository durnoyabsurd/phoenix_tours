defmodule PhoenixTours.TourController do
  use PhoenixTours.Web, :controller

  alias PhoenixTours.Tour

  def index(conn, _params) do
    tours = Repo.all(Tour)
    render(conn, "index.html", tours: tours)
  end

  def show(conn, %{"id" => id}) do
    tour = Repo.get!(Tour, id)
    render(conn, "show.html", tour: tour)
  end
end
