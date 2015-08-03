defmodule PhoenixTours.Api.CategoryView do
  use PhoenixTours.Web, :view

  alias PhoenixTours.Api.TourView

  @attributes [:id, :name, :inserted_at, :created_at]
  @list_attributes [:id, :name]

  def render("index.json", %{categories: categories}) do
    for category <- categories do
      render("index.json", %{category: category})
    end
  end

  def render("index.json", %{category: category}) do
    category |> Map.take(@list_attributes)
  end

  def render("show.json", %{category: category}) do
    category
    |> Map.take(@attributes)
    |> Map.put(:tours, TourView.render("index.json", tours: category.tours))
  end
end
