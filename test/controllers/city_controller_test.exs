defmodule PhoenixTours.CityControllerTest do
  use PhoenixTours.ConnCase

  alias PhoenixTours.City

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, city_path(conn, :index)
    assert html_response(conn, 200) =~ "Cities"
  end

  test "shows chosen resource", %{conn: conn} do
    city = Repo.insert! %City{name: "Mytischy"}
    conn = get conn, city_path(conn, :show, city)
    assert html_response(conn, 200) =~ city.name
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, city_path(conn, :show, -1)
    end
  end
end
