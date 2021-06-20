defmodule Devspot.Skills.GetTest do
  use Devspot.DataCase, async: false

  import Devspot.Factory

  alias Devspot.{Skill, User, UserSkill}
  alias Devspot.Skills.Get

  describe "all/0" do
    test "returns all skills" do
      insert(:skill)
      insert(:skill, %{id: "b721fcad-e6e8-4e8f-910b-6911f2158b4c", name: "Elixir"})

      response = Get.all()

      assert {:ok,
              [
                %Skill{
                  id: _id,
                  name: "React",
                  image_url: "https://www.lucianopastine.tech/img/about-logos/reactjs.png",
                  inserted_at: _init_date,
                  updated_at: _up_date
                }
                | _rest
              ]} = response
    end
  end

  describe "by_id/1" do
    test "when there is a skill with the given id, returns the skill" do
      %Skill{id: id} = insert(:skill)

      response = Get.by_id(id)

      assert {:ok,
              %Skill{
                id: _id,
                image_url: "https://www.lucianopastine.tech/img/about-logos/reactjs.png",
                inserted_at: _insert_date,
                name: "React",
                updated_at: _up_date
              }} = response
    end

    test "when there is no skill with the given id, returns an error" do
      response = Get.by_id("b721fcad-e6e8-4e8f-910b-6911f2158b4b")

      assert {:error, %Devspot.Error{result: "Skill not found", status: :not_found}} == response
    end
  end

  describe "user_skill_by_user_id/1" do
    test "returns the skills from the following user" do
      insert(:skill)
      %User{id: id} = insert(:user, id: "b721fcad-e6e8-4e8f-910b-6911f2158b5f")

      insert(:user_skill, user_id: id)

      response = Get.user_skill_by_user_id(id)

      assert {:ok,
              [
                %UserSkill{
                  abstract: "I studied 6 months and built an app to support medical health care",
                  id: _id,
                  skill_id: _skill_id,
                  user_id: _user_id,
                  inserted_at: _init_date,
                  updated_at: _up_date,
                  skill: %Skill{
                    id: _in_skill_id,
                    image_url: "https://www.lucianopastine.tech/img/about-logos/reactjs.png",
                    inserted_at: _insert_date,
                    name: "React",
                    updated_at: _update_date
                  }
                }
              ]} = response
    end
  end

  describe "get_user_with_skills/1" do
    test "returns all users that fills the skills requirement" do
      insert(:skill)

      %Skill{id: skill_id} =
        insert(:skill, %{id: "b721fcad-e6e8-4e8f-910b-6911f2158b4c", name: "Elixir"})

      insert(:user)

      insert(:user_skill)
      insert(:user_skill, %{id: "b721fcad-e5e8-4e8f-910b-6911f2158b4c", skill_id: skill_id})

      response = Get.get_user_with_skills("React Elixir")

      assert {:ok,
              [
                %Devspot.User{
                  contact: "54 9 9191-9292",
                  description: "bacana",
                  email: "maiqui@email.com",
                  first_name: "Maiqui",
                  id: _id,
                  image_url: "https://avatars.githubusercontent.com/u/48564739?v=4",
                  inserted_at: _insert_date,
                  last_name: "Tomé",
                  location: "Flores da Cunha/RS",
                  password: nil,
                  password_hash: nil,
                  status: :Open,
                  updated_at: _ip_date
                }
              ]} = response
    end

    test "when the value is not a string returns an error" do
      response = Get.get_user_with_skills(:react)

      expected_response = {:error, %Devspot.Error{result: "Not a string", status: :bad_request}}

      assert response == expected_response
    end
  end
end
