defmodule PhoenixTours.Tour do
  use PhoenixTours.Web, :model

  schema "tours" do
    field :title, :string
    field :description, :string
    field :published, :boolean, default: false
    belongs_to :city, City
    has_many :categories, {"categories_tours", Category}

    timestamps
  end

  @required_fields ~w(title description city_id)
  @optional_fields ~w(published)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
