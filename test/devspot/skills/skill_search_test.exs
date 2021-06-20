defmodule Devspot.Skills.SkillSearchTest do
  use Devspot.DataCase, async: false

  import Devspot.Factory

  alias Devspot.Skill
  alias Devspot.Skills.SkillSearch

  describe "search_user_by_skills/2" do
    test "returns all users that fills the skills requirement" do
      insert(:skill)

      %Skill{id: skill_id} =
        insert(:skill, %{id: "b721fcad-e6e8-4e8f-910b-6911f2158b4c", name: "Elixir"})

      insert(:user)

      insert(:user_skill)
      insert(:user_skill, %{id: "b721fcad-e5e8-4e8f-910b-6911f2158b4c", skill_id: skill_id})

      response = SkillSearch.search_user_by_skills("React", ["Elixir"])

      assert [
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
             ] = response
    end
  end
end
