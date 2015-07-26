defmodule PhoenixTours.TourControllerTest do
  use PhoenixTours.ConnCase

  alias PhoenixTours.Tour
  @valid_attrs %{city_id: 42, description: "some content", published: true, title: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, tour_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing tours"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, tour_path(conn, :new)
    assert html_response(conn, 200) =~ "New tour"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, tour_path(conn, :create), tour: @valid_attrs
    assert redirected_to(conn) == tour_path(conn, :index)
    assert Repo.get_by(Tour, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, tour_path(conn, :create), tour: @invalid_attrs
    assert html_response(conn, 200) =~ "New tour"
  end

  test "shows chosen resource", %{conn: conn} do
    tour = Repo.insert! %Tour{}
    conn = get conn, tour_path(conn, :show, tour)
    assert html_response(conn, 200) =~ "Show tour"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, tour_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    tour = Repo.insert! %Tour{}
    conn = get conn, tour_path(conn, :edit, tour)
    assert html_response(conn, 200) =~ "Edit tour"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    tour = Repo.insert! %Tour{}
    conn = put conn, tour_path(conn, :update, tour), tour: @valid_attrs
    assert redirected_to(conn) == tour_path(conn, :index)
    assert Repo.get_by(Tour, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    tour = Repo.insert! %Tour{}
    conn = put conn, tour_path(conn, :update, tour), tour: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit tour"
  end

  test "deletes chosen resource", %{conn: conn} do
    tour = Repo.insert! %Tour{}
    conn = delete conn, tour_path(conn, :delete, tour)
    assert redirected_to(conn) == tour_path(conn, :index)
    refute Repo.get(Tour, tour.id)
  end
end
