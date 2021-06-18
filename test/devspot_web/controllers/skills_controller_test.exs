defmodule DevspotWeb.SkillsControllerTest do
  use DevspotWeb.ConnCase, async: true

  import Devspot.Factory

  describe "index/2" do
    test "returns all skills", %{conn: conn} do
      insert(:skill)

      response =
        conn
        |> get(Routes.skills_path(conn, :index))
        |> json_response(:ok)

      assert %{
               "skills" => [
                 %{
                   "image_url" => "https://www.lucianopastine.tech/img/about-logos/reactjs.png",
                   "name" => "React"
                 }
               ]
             } =
               response
    end
  end
end
