defmodule PhoenixTours.Admin.CityController do
  use PhoenixTours.Web, :controller

  alias PhoenixTours.City

  plug :scrub_params, "city" when action in [:create, :update]

  def index(conn, _params) do
    cities = Repo.all(City)
    render(conn, "index.html", cities: cities)
  end

  def new(conn, _params) do
    changeset = City.changeset(%City{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"city" => city_params}) do
    changeset = City.changeset(%City{}, city_params)

    if changeset.valid? do
      Repo.insert!(changeset)

      conn
      |> put_flash(:info, "City created successfully.")
      |> redirect(to: admin_city_path(conn, :index))
    else
      render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    city = Repo.get!(City, id)
    changeset = City.changeset(city)
    render(conn, "edit.html", city: city, changeset: changeset)
  end

  def update(conn, %{"id" => id, "city" => city_params}) do
    city = Repo.get!(City, id)
    changeset = City.changeset(city, city_params)

    if changeset.valid? do
      Repo.update!(changeset)

      conn
      |> put_flash(:info, "City updated successfully.")
      |> redirect(to: admin_city_path(conn, :index))
    else
      render(conn, "edit.html", city: city, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    city = Repo.get!(City, id)
    Repo.delete!(city)

    conn
    |> put_flash(:info, "City deleted successfully.")
    |> redirect(to: admin_city_path(conn, :index))
  end
end
