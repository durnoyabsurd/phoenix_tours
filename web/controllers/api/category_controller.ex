defmodule PhoenixTours.Api.CategoryController do
  use PhoenixTours.Web, :controller
  plug :action

  alias PhoenixTours.Category
  alias PhoenixTours.Api.ErrorView

  plug :scrub_params, "category" when action in [:create, :update]

  def index(conn, _params) do
    categories = Repo.all(Category)
    render(conn, "index.json", categories: categories)
  end

  def show(conn, %{"id" => id}) do
    category = Repo.get!(Category, id) |> Repo.preload([:tours])
    render(conn, "show.json", category: category)
  end

  def create(conn, %{"category" => category_params}) do
    changeset = Category.changeset(%Category{}, category_params)

    if changeset.valid? do
      category = Repo.insert!(changeset) |> Repo.preload([:tours])

      conn
      |> put_status(201)
      |> render("show.json", category: category)
    else
      conn
      |> put_status(422)
      |> render(ErrorView, "error.json", changeset: changeset)
    end
  end

  def update(conn, %{"id" => id, "category" => category_params}) do
    category = Repo.get!(Category, id)
    changeset = Category.changeset(category, category_params)

    if changeset.valid? do
      category = Repo.update!(changeset) |> Repo.preload([:tours])
      render(conn, "show.json", category: category)
    else
      conn
      |> put_status(422)
      |> render(ErrorView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    category = Repo.get!(Category, id)

    if Repo.delete!(category) do
      conn |> put_status(204) |> halt
    else
      conn |> put_status(422) |> halt
    end
  end
end
