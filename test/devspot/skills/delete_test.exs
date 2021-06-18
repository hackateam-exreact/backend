defmodule Devspot.Skills.DeleteTest do
  use Devspot.DataCase, async: true

  import Devspot.Factory

  alias Devspot.Skills.Delete
  alias Devspot.UserSkill

  describe "for_user_skill/1" do
    test "when there is a user skill with the given id, deletes the user skill" do
      insert(:skill, id: "b721fcad-e6e8-4e8f-910b-6911f2158b53")
      insert(:user, id: "b721fcad-e6e8-4e8f-910b-6911f2158b5a")

      %UserSkill{id: id} =
        insert(:user_skill,
          id: "b721fcad-e6e8-4e8f-910b-6911f2158b5c",
          user_id: "b721fcad-e6e8-4e8f-910b-6911f2158b5a",
          skill_id: "b721fcad-e6e8-4e8f-910b-6911f2158b53"
        )

      response = Delete.for_user_skill(id)

      assert {:ok,
              %UserSkill{
                id: _id,
                abstract: "I studied 6 months and built an app to support medical health care",
                inserted_at: _insert_date,
                updated_at: _up_date,
                skill_id: _skill_id,
                user_id: _user_id
              }} = response
    end

    test "when there is no user skill with the given id, returns an error" do
      response = Delete.for_user_skill("b721fcad-e6e8-4e8f-910b-6911f2158b5c")

      assert {:error, %Devspot.Error{result: "User skill not found", status: :not_found}} =
               response
    end
  end
end
