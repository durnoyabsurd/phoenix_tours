defmodule PhoenixTours.TourControllerTest do
  use PhoenixTours.ConnCase

  alias PhoenixTours.Tour
  alias PhoenixTours.City

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, tour_path(conn, :index)
    assert html_response(conn, 200) =~ "Tours"
  end

  test "shows chosen resource", %{conn: conn} do
    city = Repo.insert! %City{name: "Mytischi"}
    tour = Repo.insert! %Tour{
      title: "Example tour",
      published: true,
      city_id: city.id}
      
    conn = get conn, tour_path(conn, :show, tour)
    assert html_response(conn, 200) =~ tour.title
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, tour_path(conn, :show, -1)
    end
  end
end
