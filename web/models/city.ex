defmodule PhoenixTours.City do
  use PhoenixTours.Web, :model

  schema "cities" do
    field :name, :string
    has_many :tours, PhoenixTours.Tour

    timestamps
  end

  @required_fields ~w(name)
  @optional_fields ~w()

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_unique(:name, on: PhoenixTours.Repo)
  end
end
