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
end
