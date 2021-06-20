defmodule DevspotWeb.SkillsController do
  use DevspotWeb, :controller

  alias Devspot.UserSkill

  alias DevspotWeb.Auth.Guardian
  alias DevspotWeb.FallbackController

  action_fallback FallbackController

  def index(conn, _params) do
    with {:ok, skills} <- Devspot.get_all_skills() do
      conn
      |> put_status(:ok)
      |> render("index.json", skills: skills)
    end
  end

  def create_user_skill(conn, params) do
    user_id = Guardian.retrieve_user_id_from_connection(conn)
    params = Map.put(params, "user_id", user_id)

    with {:ok, %UserSkill{} = user_skill} <- Devspot.create_user_skill(params) do
      conn
      |> put_status(:created)
      |> render("create.json", user_skill: user_skill)
    end
  end

  def show_user_skills(conn, %{"user_id" => user_id}) do
    with {:ok, skills} <- Devspot.get_user_skills(user_id) do
      conn
      |> put_status(:ok)
      |> render("user_skills.json", user_skills: skills)
    end
  end

  def delete_user_skill(conn, %{"user_skill_id" => user_skill_id}) do
    user_id = Guardian.retrieve_user_id_from_connection(conn)

    with {:ok, %UserSkill{}} <- Devspot.delete_user_skill(user_skill_id, user_id) do
      conn
      |> put_status(:no_content)
      |> text("")
    end
  end

  def search_user_with_skills(conn, %{"query" => query}) do
    with {:ok, user_list} <- Devspot.search_user_with_skills(query) do
      conn
      |> put_status(:ok)
      |> render(:users_with_skills, user_list: user_list)
    end
  end
end
