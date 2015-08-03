defmodule PhoenixTours.Api.TourControllerTest do
  use PhoenixTours.ConnCase

  alias PhoenixTours.Tour
  alias PhoenixTours.City
  alias PhoenixTours.Category

  @valid_attrs %{
    title: "Example tour",
    city_id: 43,
    category_ids: [57, 58],
    published: true}

  @invalid_attrs %{city_id: nil}

  setup do
    Repo.insert!(%City{id: 43, name: "Jerusalem"})
    Repo.insert!(%Category{id: 57, name: "Alko tours"})
    Repo.insert!(%Category{id: 58, name: "Narko tours"})

    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    Repo.insert!(%Tour{title: "Museum skip-the-line ticket", city_id: 43})
    Repo.insert!(%Tour{title: "Overview tour", city_id: 43})
    conn = get conn, api_tour_path(conn, :index)
    assert conn.status == 200
    assert conn.resp_body =~ "Museum skip-the-line ticket"
    assert conn.resp_body =~ "Overview tour"
  end

  test "creates resource when data is valid", %{conn: conn} do
    conn = post conn, api_tour_path(conn, :create), tour: @valid_attrs
    assert conn.status == 201
    assert conn.resp_body =~ "Example tour"
    assert Repo.get_by(Tour, %{title: "Example tour", city_id: 43, published: true})
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, api_tour_path(conn, :create), tour: @invalid_attrs
    assert conn.status == 422
    assert conn.resp_body =~ "can't be blank"
  end

  test "updates chosen resource when data is valid", %{conn: conn} do
    tour = Repo.insert! %Tour{title: "Overview with dinner", city_id: 43}
    conn = put conn, api_tour_path(conn, :update, tour), tour: @valid_attrs
    assert conn.status == 200
    assert conn.resp_body =~ "Example tour"
    assert Repo.get_by(Tour, %{title: "Example tour", city_id: 43, published: true})
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    tour = Repo.insert! %Tour{title: "Exterme moped racing", city_id: 43}
    conn = put conn, api_tour_path(conn, :update, tour), tour: @invalid_attrs
    assert conn.status == 422
    assert conn.resp_body =~ "can't be blank"
  end

  test "deletes chosen resource", %{conn: conn} do
    tour = Repo.insert! %Tour{title: "All day shopping tour", city_id: 43}
    conn = delete conn, api_tour_path(conn, :delete, tour)
    assert conn.status == 204
    refute Repo.get(Tour, tour.id)
  end
end
