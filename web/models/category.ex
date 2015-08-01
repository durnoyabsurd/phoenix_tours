defmodule PhoenixTours.Category do
  use PhoenixTours.Web, :model

  schema "categories" do
    field :name, :string
    has_many :tour_categories, PhoenixTours.TourCategory
    has_many :tours, through: [:tour_categories, :tour]

    timestamps
  end

  @required_fields ~w(name)
  @optional_fields ~w()

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
