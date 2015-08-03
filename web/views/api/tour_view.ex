defmodule PhoenixTours.Api.TourView do
  use PhoenixTours.Web, :view

  alias PhoenixTours.Api.CityView
  alias PhoenixTours.Api.CategoryView

  @attributes [:id, :title, :description, :published, :inserted_at, :updated_at]
  @list_attributes [:id, :title, :published]

  def render("index.json", %{tours: tours}) do
    for tour <- tours do
      render("index.json", %{tour: tour})
    end
  end

  def render("index.json", %{tour: tour}) do
    tour |> Map.take(@list_attributes)
  end

  def render("show.json", %{tour: tour}) do
    tour
    |> Map.take(@attributes)
    |> Map.put(:city, CityView.render("index.json", city: tour.city))
    |> Map.put(:categories, CategoryView.render("index.json", categories: tour.categories))
  end
end
