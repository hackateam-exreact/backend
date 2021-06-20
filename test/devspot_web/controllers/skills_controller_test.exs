defmodule DevspotWeb.SkillsControllerTest do
  use DevspotWeb.ConnCase, async: false

  import Devspot.Factory

  alias Devspot.{Skill, UserSkill}
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

    test "when there's no user skill with the given id, returns an error", %{
      conn: conn
    } do
      user_skill_id = "b721fcad-e6e8-4e8f-910b-6911f2158b4f"

      response =
        conn
        |> delete(Routes.skills_path(conn, :delete_user_skill, user_skill_id))
        |> json_response(:not_found)

      expected_response = %{"message" => "User skill not found"}

      assert response == expected_response
    end
  end

  describe "search_user_with_skills/2" do
    test "returns all users with the given skills", %{conn: conn} do
      insert(:skill)

      %Skill{id: skill_id} =
        insert(:skill, %{id: "b721fcad-e6e8-4e8f-910b-6911f2158b4c", name: "Elixir"})

      insert(:user)

      insert(:user_skill)
      insert(:user_skill, %{id: "b721fcad-e5e8-4e8f-910b-6911f2158b4c", skill_id: skill_id})

      query = "React Elixir"

      response =
        conn
        |> get(Routes.skills_path(conn, :search_user_with_skills, query))
        |> json_response(:ok)

      assert %{
               "user_list" => [
                 %{
                   "contact" => "54 9 9191-9292",
                   "description" => "bacana",
                   "email" => "maiqui@email.com",
                   "first_name" => "Maiqui",
                   "id" => "b721fcad-e6e8-4e8f-910b-6911f2158b4a",
                   "image_url" => "https://avatars.githubusercontent.com/u/48564739?v=4",
                   "last_name" => "Tomé",
                   "location" => "Flores da Cunha/RS",
                   "status" => "Open"
                 }
               ]
             } = response
    end
  end
end
