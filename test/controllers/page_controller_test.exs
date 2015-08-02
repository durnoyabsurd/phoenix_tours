defmodule PhoenixTours.PageControllerTest do
  use PhoenixTours.ConnCase

  test "GET /" do
    conn = get conn(), "/"
    assert html_response(conn, 200) =~ "Tours"
  end
end
