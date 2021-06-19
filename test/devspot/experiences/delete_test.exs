defmodule Devspot.Experiences.DeleteTest do
  use Devspot.DataCase, async: true

  import Devspot.Factory

  alias Devspot.Experience
  alias Devspot.Experiences.Delete

  describe "call/1" do
    test "when there is an experience with the given id, deletes the experience" do
      insert(:user)
      %Experience{id: experience_id} = insert(:experience)

      response = Delete.call(experience_id)

      assert {:ok, %Experience{}} = response
    end

    test "when there is no an experience with the given id, returns an error" do
      experience_id = "b721fcad-e6e8-4e8f-910b-6911f2158b4a"

      response = Delete.call(experience_id)

      expected_response =
        {:error, %Devspot.Error{result: "Experience not found", status: :not_found}}

      assert response == expected_response
    end
  end
end
