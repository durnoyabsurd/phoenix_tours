defmodule PhoenixTours.Router do
  use PhoenixTours.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  pipeline :admin do
    plug PlugBasicAuth, username: "admin", password: "admin"
    plug :put_layout, {PhoenixTours.LayoutView, "admin.html"}
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PhoenixTours do
    pipe_through :browser # Use the default browser stack

    get "/", TourController, :index

    resources "/tours", TourController, only: [:index, :show]
    resources "/cities", CityController, only: [:index, :show]
    resources "/categories", CategoryController, only: [:index]
  end

  scope "/admin", PhoenixTours, as: :admin do
    pipe_through [:browser, :admin]

    get "/", Admin.ToursController, :index

    resources "/tours", Admin.TourController, except: [:show]
    resources "/cities", Admin.CityController, except: [:show]
    resources "/categories", Admin.CategoryController, except: [:show]
  end

  # Other scopes may use custom stacks.
  # scope "/api", PhoenixTours do
  #   pipe_through :api
  # end
end
