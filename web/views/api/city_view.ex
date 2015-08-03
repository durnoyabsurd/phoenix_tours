defmodule PhoenixTours.Api.CityView do
  use PhoenixTours.Web, :view

  alias PhoenixTours.Api.TourView

  @attributes [:id, :name, :inserted_at, :created_at]
  @list_attributes [:id, :name]

  def render("index.json", %{cities: cities}) do
    for city <- cities do
      render("index.json", %{city: city})
    end
  end

  def render("index.json", %{city: city}) do
    city |> Map.take(@list_attributes)
  end

  def render("show.json", %{city: city}) do
    city
    |> Map.take(@attributes)
    |> Map.put(:tours, TourView.render("index.json", tours: city.tours))
  end
end
