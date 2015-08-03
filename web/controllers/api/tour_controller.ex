defmodule PhoenixTours.Api.TourController do
  use PhoenixTours.Web, :controller
  plug :action

  alias PhoenixTours.Tour
  alias PhoenixTours.Api.ErrorView

  plug :scrub_params, "tour" when action in [:create, :update]

  def index(conn, _params) do
    tours = Repo.all(Tour)
    render(conn, "index.json", tours: tours)
  end

  def show(conn, %{"id" => id}) do
    tour = Repo.get!(Tour, id) |> Repo.preload([:city, :categories])
    render(conn, "show.json", tour: tour)
  end

  def create(conn, %{"tour" => tour_params}) do
    changeset = Tour.changeset(%Tour{}, tour_params)

    if changeset.valid? do
      tour = Repo.insert!(changeset) |> Repo.preload([:city, :categories])

      conn
      |> put_status(201)
      |> render("show.json", tour: tour)
    else
      conn
      |> put_status(422)
      |> render(ErrorView, "error.json", changeset: changeset)
    end
  end

  def update(conn, %{"id" => id, "tour" => tour_params}) do
    tour = Repo.get!(Tour, id)
    changeset = Tour.changeset(tour, tour_params)

    if changeset.valid? do
      tour = Repo.update!(changeset) |> Repo.preload([:city, :categories])
      render(conn, "show.json", tour: tour)
    else
      conn
      |> put_status(422)
      |> render(ErrorView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    tour = Repo.get!(Tour, id)

    if Repo.delete!(tour) do
      conn |> put_status(204) |> halt
    else
      conn |> put_status(422) |> halt
    end
  end
end
