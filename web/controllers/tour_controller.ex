defmodule PhoenixTours.TourController do
  use PhoenixTours.Web, :controller

  alias PhoenixTours.Tour

  plug :find_tours

  def index(conn, _params) do
    tours = Repo.all(conn.assigns[:query])
    render(conn, "index.html", tours: tours)
  end

  def show(conn, %{"id" => id}) do
    case Repo.get(conn.assigns[:query], id) do
      nil ->
        conn
          |> put_status(:not_found)
          |> render(PhoenixTours.ErrorView, "404.html")
      tour ->
        render(conn, "show.html", tour: tour)
    end
  end

  def find_tours(conn, _params) do
    query = from t in Tour,
              where: t.published,
              join: c in assoc(t, :city),
              preload: [city: c]

    assign(conn, :query, query)
  end
end
