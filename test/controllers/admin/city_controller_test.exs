defmodule PhoenixTours.Admin.CityControllerTest do
  use PhoenixTours.ConnCase

  alias PhoenixTours.City
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, admin_city_path(conn, :index)
    assert html_response(conn, 200) =~ "Cities"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, admin_city_path(conn, :new)
    assert html_response(conn, 200) =~ "New city"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, admin_city_path(conn, :create), city: @valid_attrs
    assert redirected_to(conn) == admin_city_path(conn, :index)
    assert Repo.get_by(City, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, admin_city_path(conn, :create), city: @invalid_attrs
    assert html_response(conn, 200) =~ "New city"
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    city = Repo.insert! %City{}
    conn = get conn, admin_city_path(conn, :edit, city)
    assert html_response(conn, 200) =~ "Edit city"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    city = Repo.insert! %City{}
    conn = put conn, admin_city_path(conn, :update, city), city: @valid_attrs
    assert redirected_to(conn) == admin_city_path(conn, :index)
    assert Repo.get_by(City, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    city = Repo.insert! %City{}
    conn = put conn, admin_city_path(conn, :update, city), city: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit city"
  end

  test "deletes chosen resource", %{conn: conn} do
    city = Repo.insert! %City{}
    conn = delete conn, admin_city_path(conn, :delete, city)
    assert redirected_to(conn) == admin_city_path(conn, :index)
    refute Repo.get(City, city.id)
  end
end
