defmodule PhoenixTours.Admin.DescriptionControllerTest do
  use PhoenixTours.ConnCase

  alias PhoenixTours.Tour
  alias PhoenixTours.City

  setup context do
    if context[:fixtures] do
      Repo.insert! %City{id: 42, name: "Mytischi"}
      Repo.insert! %Tour{title: "Has description", description: "desc", city_id: 42}
      Repo.insert! %Tour{title: "No description", city_id: 42}
    end

    conn = conn()
    {:ok, conn: conn}
  end

  @tag fixtures: true
  test "shows a tour without description", %{conn: conn} do
    conn = get conn, admin_description_path(conn, :index)
    assert html_response(conn, 200) =~ "No description"
  end

  test "shows happy page", %{conn: conn} do
    conn = get conn, admin_description_path(conn, :index)
    assert html_response(conn, 200) =~ "Well done!"
  end

  @tag fixtures: true
  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    tour = Repo.insert! %Tour{title: "No description either", city_id: 42}

    conn = put conn,
               admin_description_path(conn, :update, tour),
               tour: %{description: "desc"}

    assert redirected_to(conn) == admin_description_path(conn, :index)
    assert Repo.get!(Tour, tour.id).description == "desc"
  end
end
