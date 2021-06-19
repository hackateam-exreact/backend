defmodule DevspotWeb.ExperiencesController do
  use DevspotWeb, :controller

  alias Devspot.Experience

  alias DevspotWeb.{Auth.Guardian, FallbackController}

  action_fallback FallbackController

  def create(conn, params) do
    user_id = Guardian.retrieve_user_id_from_connection(conn)
    params = Map.put(params, "user_id", user_id)

    with {:ok, %Experience{} = experience} <- Devspot.create_experience(params) do
      conn
      |> put_status(:created)
      |> render("create.json", experience: experience)
    end
  end

  def show(conn, %{"user_id" => user_id}) do
    with {:ok, experiences_list} <- Devspot.get_all_experiences(user_id) do
      conn
      |> put_status(:ok)
      |> render("experiences_list.json", experiences_list: experiences_list)
    end
  end

  def delete(conn, %{"id" => experience_id}) do
    with {:ok, %Experience{}} <- Devspot.delete_experience(experience_id) do
      conn
      |> put_status(:no_content)
      |> text("")
    end
  end
end
