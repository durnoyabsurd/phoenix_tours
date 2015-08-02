defmodule PhoenixTours.Admin.TourControllerTest do
  use PhoenixTours.ConnCase

  alias PhoenixTours.Tour
  alias PhoenixTours.City

  @valid_attrs %{
    city_id: 42,
    description: "some content",
    published: true,
    title: "some content"}

  @invalid_attrs %{}

  setup do
    Repo.insert! %City{id: 42, name: "Mytischi"}

    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, admin_tour_path(conn, :index)
    assert html_response(conn, 200) =~ "Tours"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, admin_tour_path(conn, :new)
    assert html_response(conn, 200) =~ "New tour"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, admin_tour_path(conn, :create), tour: @valid_attrs
    assert redirected_to(conn) == admin_tour_path(conn, :index)
    assert Repo.get_by(Tour, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, admin_tour_path(conn, :create), tour: @invalid_attrs
    assert html_response(conn, 200) =~ "New tour"
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    tour = Repo.insert! %Tour{}
    conn = get conn, admin_tour_path(conn, :edit, tour)
    assert html_response(conn, 200) =~ "Edit tour"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    tour = Repo.insert! %Tour{}
    conn = put conn, admin_tour_path(conn, :update, tour), tour: @valid_attrs
    assert redirected_to(conn) == admin_tour_path(conn, :index)
    assert Repo.get_by(Tour, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    tour = Repo.insert! %Tour{}
    conn = put conn, admin_tour_path(conn, :update, tour), tour: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit tour"
  end

  test "deletes chosen resource", %{conn: conn} do
    tour = Repo.insert! %Tour{}
    conn = delete conn, admin_tour_path(conn, :delete, tour)
    assert redirected_to(conn) == admin_tour_path(conn, :index)
    refute Repo.get(Tour, tour.id)
  end
end
