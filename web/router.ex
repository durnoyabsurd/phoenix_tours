defmodule PhoenixTours.Router do
  use PhoenixTours.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  pipeline :admin do
    plug :put_layout, {PhoenixTours.LayoutView, "admin.html"}
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PhoenixTours do
    pipe_through :browser

    get "/", TourController, :index

    resources "/tours", TourController, only: [:index, :show]
    resources "/cities", CityController, only: [:index, :show]
    resources "/categories", CategoryController, only: [:index, :show]
  end

  scope "/admin", PhoenixTours, as: :admin do
    pipe_through [:browser, :admin]

    get "/", Admin.TourController, :index

    resources "/tours", Admin.TourController, except: [:show]
    resources "/cities", Admin.CityController, except: [:show]
    resources "/categories", Admin.CategoryController, except: [:show]
    resources "/description", Admin.DescriptionController, only: [:index, :update]
  end

  scope "/api", PhoenixTours, as: :api do
    pipe_through :api

    resources "/tours", Api.TourController, except: [:new, :edit]
    resources "/cities", Api.CityController, except: [:new, :edit]
    resources "/categories", Api.CategoryController, except: [:new, :edit]
  end
end
