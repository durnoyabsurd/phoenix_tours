defmodule PhoenixTours.Tour do
  use PhoenixTours.Web, :model

  schema "tours" do
    field :title, :string
    field :description, :string
    field :published, :boolean, default: false
    belongs_to :city, PhoenixTours.City
    has_many :categories, {"categories_tours", PhoenixTours.Category}

    timestamps
  end

  @required_fields ~w(title city_id)
  @optional_fields ~w(description published)

  # TODO: save categories
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
