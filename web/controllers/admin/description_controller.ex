defmodule PhoenixTours.Admin.DescriptionController do
  use PhoenixTours.Web, :controller

  alias PhoenixTours.Tour

  plug :scrub_params, "tour" when action in [:update]

  def index(conn, _params) do
    query = from t in Tour,
              where: is_nil(t.description),
              order_by: t.inserted_at,
              limit: 1

    tour = Repo.one(query)
    changeset = tour && Tour.changeset(tour)
    render(conn, "index.html", tour: tour, changeset: changeset)
  end

  def update(conn, %{"id" => id, "tour" => tour_params}) do
    tour = Repo.get!(Tour, id)
    changeset = Tour.changeset(tour, tour_params)

    if changeset.valid? do
      Repo.update!(changeset)
    end

    conn
    |> redirect(to: admin_description_path(conn, :index))
  end
end
