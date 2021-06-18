defmodule Devspot.Skills.CreateTest do
  use Devspot.DataCase, async: true

  import Devspot.Factory

  alias Devspot.{Error, Skill}
  alias Devspot.Skills.Create

  describe "call/1" do
    test "when all params are valid, returns the skill" do
      params = build(:skill_params)

      response = Create.call(params)

      assert {:ok, %Skill{id: _id, name: "React", image_url: _image_url}} = response
    end

    test "when there are invalid params, returns an error" do
      params = %{"name" => "React"}

      response = Create.call(params)

      expected_response = %{image_url: ["can't be blank"]}

      assert {:error, %Error{result: changeset, status: :bad_request}} = response

      assert errors_on(changeset) == expected_response
    end
  end

  describe "for_user_skill/1" do
    test "when all params are valid, returns a user skill" do
      insert(:user)
      insert(:skill)

      params = build(:user_skill_params)

      response = Create.for_user_skill(params)

      assert {:ok,
              %Devspot.UserSkill{
                abstract: "I studied 6 months and built an app to support medical health care",
                id: _id,
                inserted_at: _insert_date,
                skill_id: _skill_id,
                updated_at: _up_date,
                user_id: _user_id
              }} = response
    end

    test "when there are invalid params returns an error" do
      insert(:user)
      insert(:skill)

      params = %{
        "user_id" => "b721fcad-e6e8-4e8f-910b-6911f2158b4a",
        "skill_id" => "b721fcad-e6e8-4e8f-910b-6911f2158b4b"
      }

      response = Create.for_user_skill(params)

      expected_response = %{abstract: ["can't be blank"]}

      assert {:error, %Error{result: changeset, status: :bad_request}} = response

      assert errors_on(changeset) == expected_response
    end
  end
end
