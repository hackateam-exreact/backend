defmodule DevspotWeb.SkillsControllerTest do
  use DevspotWeb.ConnCase, async: false

  import Devspot.Factory

  alias Devspot.UserSkill
  alias DevspotWeb.Auth.Guardian, as: AuthGuardian

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
                   "id" => _id,
                   "image_url" => "https://www.lucianopastine.tech/img/about-logos/reactjs.png",
                   "name" => "React"
                 }
               ]
             } = response
    end
  end

  describe "create_user_skill/2" do
    test "when all params are valid, returns a user skill", %{conn: conn} do
      user = insert(:user)
      {:ok, token, _claims} = AuthGuardian.encode_and_sign(user)

      conn = put_req_header(conn, "authorization", "Bearer #{token}")

      insert(:skill)

      params = build(:user_skill_params)

      response =
        conn
        |> post(Routes.skills_path(conn, :create_user_skill, params))
        |> json_response(:created)

      assert %{
               "message" => "User skills created!",
               "user_skill" => %{
                 "abstract" =>
                   "I studied 6 months and built an app to support medical health care",
                 "id" => _id,
                 "skill" => %{
                   "id" => _in_skill_id,
                   "image_url" => "https://www.lucianopastine.tech/img/about-logos/reactjs.png",
                   "name" => "React"
                 },
                 "skill_id" => _skill_id,
                 "user_id" => _user_id
               }
             } = response
    end
  end

  describe "delete_user_skill/2" do
    setup %{conn: conn} do
      user = insert(:user)
      insert(:skill)

      %UserSkill{id: user_skill_id} = insert(:user_skill)
      {:ok, token, _claims} = AuthGuardian.encode_and_sign(user)
      conn = put_req_header(conn, "authorization", "Bearer #{token}")

      {:ok, conn: conn, user_skill_id: user_skill_id}
    end

    test "when the user skills exists, deletes the user skill", %{
      conn: conn,
      user_skill_id: user_skill_id
    } do
      response =
        conn
        |> delete(Routes.skills_path(conn, :delete_user_skill, user_skill_id))
        |> response(:no_content)

      assert response == ""
    end
  end
end
