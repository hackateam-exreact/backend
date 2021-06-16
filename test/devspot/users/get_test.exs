defmodule Devspot.Users.GetTest do
  use Devspot.DataCase, async: true

  import Devspot.Factory

  alias Devspot.{Error, User}
  alias Devspot.Users.Get

  describe "by_id/1" do
    test "when there is an user with the given id, returns an user" do
      id = "b721fcad-e6e8-4e8f-910b-6911f2158b4a"

      insert(:user)

      assert {:ok, %User{}} = Get.by_id(id)
    end

    test "when there is no an user with the given id, returns an error" do
      id = "b721fcad-e6e8-4e8f-910b-6911f2158b4a"

      expected_response = {:error, %Error{result: "User not found", status: :not_found}}

      response = Get.by_id(id)

      assert response == expected_response
    end
  end
end
