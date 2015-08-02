defmodule PhoenixTours.CategoryControllerTest do
  use PhoenixTours.ConnCase

  alias PhoenixTours.Category
  
  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, category_path(conn, :index)
    assert html_response(conn, 200) =~ "Categories"
  end

  test "shows chosen resource", %{conn: conn} do
    category = Repo.insert! %Category{name: "test category"}
    conn = get conn, category_path(conn, :show, category)
    assert html_response(conn, 200) =~ category.name
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, category_path(conn, :show, -1)
    end
  end
end
