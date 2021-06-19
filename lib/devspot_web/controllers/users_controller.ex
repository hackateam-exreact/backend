defmodule DevspotWeb.UsersController do
  use DevspotWeb, :controller

  alias Devspot.User
  alias DevspotWeb.FallbackController

  alias DevspotWeb.Auth.Guardian

  action_fallback FallbackController

  def sign_in(conn, params) do
    with {:ok, token} <- Guardian.authenticate(params) do
      conn
      |> put_status(:ok)
      |> render("sign_in.json", token: token)
    end
  end

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

  def update(conn, params) do
    user_id = Guardian.retrieve_user_id_from_connection(conn)
    params = Map.put(params, "id", user_id)

    with {:ok, %User{} = user} <- Devspot.update_user(params) do
      conn
      |> put_status(:ok)
      |> render("update.json", user: user)
    end
  end
end
