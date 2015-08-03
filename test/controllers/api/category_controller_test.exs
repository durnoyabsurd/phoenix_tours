defmodule PhoenixTours.Api.CategoryControllerTest do
  use PhoenixTours.ConnCase

  alias PhoenixTours.Category
  
  @valid_attrs %{name: "Walking tours"}
  @invalid_attrs %{name: nil}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    Repo.insert!(%Category{name: "Bus tours"})
    Repo.insert!(%Category{name: "Museum tickets"})
    conn = get conn, api_category_path(conn, :index)
    assert conn.status == 200
    assert conn.resp_body =~ "Bus tours"
    assert conn.resp_body =~ "Museum tickets"
  end

  test "creates resource when data is valid", %{conn: conn} do
    conn = post conn, api_category_path(conn, :create), category: @valid_attrs
    assert conn.status == 201
    assert conn.resp_body =~ "Walking tours"
    assert Repo.get_by(Category, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, api_category_path(conn, :create), category: @invalid_attrs
    assert conn.status == 422
    assert conn.resp_body =~ "can't be blank"
  end

  test "updates chosen resource when data is valid", %{conn: conn} do
    category = Repo.insert! %Category{name: "Beer tours"}
    conn = put conn, api_category_path(conn, :update, category), category: @valid_attrs
    assert conn.status == 200
    assert conn.resp_body =~ "Walking tours"
    assert Repo.get_by(Category, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    category = Repo.insert! %Category{name: "Shopping tours"}
    conn = put conn, api_category_path(conn, :update, category), category: @invalid_attrs
    assert conn.status == 422
    assert conn.resp_body =~ "can't be blank"
  end

  test "deletes chosen resource", %{conn: conn} do
    category = Repo.insert! %Category{name: "Sex tourism"}
    conn = delete conn, api_category_path(conn, :delete, category)
    assert conn.status == 204
    refute Repo.get(Category, category.id)
  end
end
