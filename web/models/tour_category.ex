defmodule PhoenixTours.TourCategory do
  use PhoenixTours.Web, :model

  schema "tour_categories" do
    belongs_to :tour, PhoenixTours.Tour
    belongs_to :category, PhoenixTours.Category
  end

  @required_fields ~w(tour_id category_id)
  @optional_fields ~w()

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
