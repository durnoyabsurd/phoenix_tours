defmodule PhoenixTours.Api.CityControllerTest do
  use PhoenixTours.ConnCase

  alias PhoenixTours.City
  
  @valid_attrs %{name: "Lyubertsy"}
  @invalid_attrs %{name: nil}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    Repo.insert!(%City{name: "Mytischi"})
    Repo.insert!(%City{name: "Dolgoprudny"})
    conn = get conn, api_city_path(conn, :index)
    assert conn.status == 200
    assert conn.resp_body =~ "Mytischi"
    assert conn.resp_body =~ "Dolgoprudny"
  end

  test "creates resource when data is valid", %{conn: conn} do
    conn = post conn, api_city_path(conn, :create), city: @valid_attrs
    assert conn.status == 201
    assert conn.resp_body =~ "Lyubertsy"
    assert Repo.get_by(City, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, api_city_path(conn, :create), city: @invalid_attrs
    assert conn.status == 422
    assert conn.resp_body =~ "can't be blank"
  end

  test "updates chosen resource when data is valid", %{conn: conn} do
    city = Repo.insert! %City{name: "Elektrougli"}
    conn = put conn, api_city_path(conn, :update, city), city: @valid_attrs
    assert conn.status == 200
    assert conn.resp_body =~ "Lyubertsy"
    assert Repo.get_by(City, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    city = Repo.insert! %City{name: "Lobnya"}
    conn = put conn, api_city_path(conn, :update, city), city: @invalid_attrs
    assert conn.status == 422
    assert conn.resp_body =~ "can't be blank"
  end

  test "deletes chosen resource", %{conn: conn} do
    city = Repo.insert! %City{name: "Podolsk"}
    conn = delete conn, api_city_path(conn, :delete, city)
    assert conn.status == 204
    refute Repo.get(City, city.id)
  end
end
