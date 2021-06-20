defmodule DevspotWeb.ProjectsController do
  use DevspotWeb, :controller

  alias Devspot.Project

  alias DevspotWeb.{Auth.Guardian, FallbackController}

  action_fallback FallbackController

  def create(conn, params) do
    user_id = Guardian.retrieve_user_id_from_connection(conn)
    params = Map.put(params, "user_id", user_id)

    with {:ok, %Project{} = project} <- Devspot.create_project(params) do
      conn
      |> put_status(:created)
      |> render("create.json", project: project)
    end
  end

  def show(conn, %{"user_id" => user_id}) do
    with {:ok, projects_list} <- Devspot.get_all_projects(user_id) do
      conn
      |> put_status(:ok)
      |> render("projects_list.json", projects_list: projects_list)
    end
  end

  def delete(conn, %{"id" => project_id}) do
    user_id = Guardian.retrieve_user_id_from_connection(conn)

    with {:ok, %Project{}} <- Devspot.delete_project(project_id, user_id) do
      conn
      |> put_status(:no_content)
      |> text("")
    end
  end
end
