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
end
