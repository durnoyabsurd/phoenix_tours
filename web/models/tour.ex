defmodule PhoenixTours.Tour do
  use PhoenixTours.Web, :model

  schema "tours" do
    field :title, :string
    field :description, :string
    field :published, :boolean, default: false
    belongs_to :city, PhoenixTours.City
    has_many :tour_categories, PhoenixTours.TourCategory
    has_many :categories, through: [:tour_categories, :categories]
    field :category_ids, {:array, :integer}, virtual: true

    timestamps
  end

  @required_fields ~w(title city_id)
  @optional_fields ~w(description published)

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
