defmodule PhoenixTours.Api.CityController do
  use PhoenixTours.Web, :controller
  plug :action

  alias PhoenixTours.City
  alias PhoenixTours.Api.ErrorView

  plug :scrub_params, "city" when action in [:create, :update]

  def index(conn, _params) do
    cities = Repo.all(City)
    render(conn, "index.json", cities: cities)
  end

  def show(conn, %{"id" => id}) do
    city = Repo.get!(City, id) |> Repo.preload([:tours])
    render(conn, "show.json", city: city)
  end

  def create(conn, %{"city" => city_params}) do
    changeset = City.changeset(%City{}, city_params)

    if changeset.valid? do
      city = Repo.insert!(changeset) |> Repo.preload([:tours])

      conn
      |> put_status(201)
      |> render("show.json", city: city)
    else
      conn
      |> put_status(422)
      |> render(ErrorView, "error.json", changeset: changeset)
    end
  end

  def update(conn, %{"id" => id, "city" => city_params}) do
    city = Repo.get!(City, id)
    changeset = City.changeset(city, city_params)

    if changeset.valid? do
      city = Repo.update!(changeset) |> Repo.preload([:tours])
      render(conn, "show.json", city: city)
    else
      conn
      |> put_status(422)
      |> render(ErrorView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    city = Repo.get!(City, id)

    if Repo.delete!(city) do
      conn |> put_status(204) |> halt
    else
      conn |> put_status(422) |> halt
    end
  end
end
