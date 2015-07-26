defmodule PhoenixTours.PageController do
  use PhoenixTours.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
