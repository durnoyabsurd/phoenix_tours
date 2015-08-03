defmodule PhoenixTours.Api.ErrorView do
  use PhoenixTours.Web, :view

  def render("error.json", %{changeset: changeset}) do
    errors = changeset.errors
            |> Enum.map fn({attr, message}) ->
              Map.new |> Map.put(attr, message)
            end

    Map.new |> Map.put(:errors, errors)
  end
end
