defmodule PhoenixTours.Admin.TourController do
  use PhoenixTours.Web, :controller

  alias PhoenixTours.Tour
  alias PhoenixTours.TourCategory
  alias PhoenixTours.City

  plug :scrub_params, "tour" when action in [:create, :update]
  plug :find_tour when action in [:update, :edit, :delete]

  def index(conn, _params) do
    tours = Repo.all from t in Tour,
                       join: c in assoc(t, :city),
                       preload: [city: c],
                       order_by: t.inserted_at

    render(conn, "index.html", tours: tours)
  end

  def new(conn, _params) do
    changeset = Tour.changeset(%Tour{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"tour" => tour_params}) do
    changeset = Tour.changeset(%Tour{}, tour_params)

    if changeset.valid? do
      Repo.transaction(fn ->
        tour = Repo.insert!(changeset)
        update_categories(tour, tour_params)
      end)

      conn
      |> put_flash(:info, "Tour created successfully.")
      |> redirect(to: admin_tour_path(conn, :index))
    else
      render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, _params) do
    changeset = Tour.changeset(conn.assigns[:tour])
    render(conn, "edit.html", tour: conn.assigns[:tour], changeset: changeset)
  end

  def update(conn, %{"tour" => tour_params}) do
    tour = conn.assigns[:tour]
    changeset = Tour.changeset(tour, tour_params)

    if changeset.valid? do
      Repo.transaction(fn ->
        Repo.update!(changeset)
        update_categories(tour, tour_params)
      end)

      conn
      |> put_flash(:info, "Tour updated successfully.")
      |> redirect(to: admin_tour_path(conn, :index))
    else
      render(conn, "edit.html", tour: tour, changeset: changeset)
    end
  end

  def delete(conn, _params) do
    Repo.delete!(conn.assigns[:tour])

    conn
    |> put_flash(:info, "Tour deleted successfully.")
    |> redirect(to: admin_tour_path(conn, :index))
  end

  defp find_tour(conn, _) do
    tour = Repo.get!(Tour, conn.params["id"])
           |> Repo.preload([:tour_categories])

    assign(conn, :tour, tour)
  end

  defp update_categories(tour, tour_params) do
    Repo.delete_all from tc in TourCategory, where: tc.tour_id == ^(tour.id)

    case Dict.fetch(tour_params, "category_ids") do
      {:ok, category_ids} ->
        for category_id <- category_ids do
          tour_category_changeset = TourCategory.changeset(
            %TourCategory{},
            %{ "category_id" => category_id,
               "tour_id" => tour.id})

          Repo.insert(tour_category_changeset)
        end
      :error ->
    end
  end
end
