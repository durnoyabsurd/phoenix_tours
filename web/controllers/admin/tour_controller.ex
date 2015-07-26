defmodule PhoenixTours.Admin.TourController do
  use PhoenixTours.Web, :controller

  alias PhoenixTours.Tour
  alias PhoenixTours.City
  import Ecto.Query

  plug :scrub_params, "tour" when action in [:create, :update]

  def index(conn, _params) do
    tours = Repo.all from t in Tour, preload: [:city]
    render(conn, "index.html", tours: tours)
  end

  def new(conn, _params) do
    changeset = Tour.changeset(%Tour{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"tour" => tour_params}) do
    changeset = Tour.changeset(%Tour{}, tour_params)

    if changeset.valid? do
      Repo.insert!(changeset)

      conn
      |> put_flash(:info, "Tour created successfully.")
      |> redirect(to: admin_tour_path(conn, :index))
    else
      render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    tour = Repo.get!(Tour, id)
    changeset = Tour.changeset(tour)
    render(conn, "edit.html", tour: tour, changeset: changeset)
  end

  def update(conn, %{"id" => id, "tour" => tour_params}) do
    tour = Repo.get!(Tour, id)
    changeset = Tour.changeset(tour, tour_params)

    if changeset.valid? do
      Repo.update!(changeset)

      conn
      |> put_flash(:info, "Tour updated successfully.")
      |> redirect(to: admin_tour_path(conn, :index))
    else
      render(conn, "edit.html", tour: tour, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    tour = Repo.get!(Tour, id)
    Repo.delete!(tour)

    conn
    |> put_flash(:info, "Tour deleted successfully.")
    |> redirect(to: admin_tour_path(conn, :index))
  end
end
