defmodule PhoenixTours.TourTest do
  use PhoenixTours.ModelCase

  alias PhoenixTours.Tour

  @valid_attrs %{city_id: 42, description: "some content", published: true, title: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Tour.changeset(%Tour{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Tour.changeset(%Tour{}, @invalid_attrs)
    refute changeset.valid?
  end
end
