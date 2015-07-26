defmodule PhoenixTours.Router do
  use PhoenixTours.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PhoenixTours do
    pipe_through :browser # Use the default browser stack

    get "/", TourController, :index

    resources "/tours", TourController
    resources "/cities", CityController
    resources "/categories", CategoryController
  end

  # Other scopes may use custom stacks.
  # scope "/api", PhoenixTours do
  #   pipe_through :api
  # end
end
