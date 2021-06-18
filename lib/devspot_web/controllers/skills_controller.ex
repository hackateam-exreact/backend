defmodule DevspotWeb.SkillsController do
  use DevspotWeb, :controller

  alias DevspotWeb.FallbackController

  action_fallback FallbackController

  def index(conn, _params) do
    with {:ok, skills} <- Devspot.get_all_skills() do
      conn
      |> put_status(:ok)
      |> render("index.json", skills: skills)
    end
  end
end
