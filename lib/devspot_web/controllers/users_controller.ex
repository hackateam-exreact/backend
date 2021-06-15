defmodule DevspotWeb.UsersController do
  use DevspotWeb, :controller

  alias Devspot.User

  def create(conn, params) do
    with {:ok, %User{} = user} <- Devspot.create_user(params) do
      conn
      |> put_status(:created)
      |> render("create.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, %User{} = user} <- Devspot.get_user_by_id(id) do
      conn
      |> put_status(:ok)
      |> render("user.json", user: user)
    end
  end
end
