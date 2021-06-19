defmodule Devspot.Experiences.GetTest do
  use Devspot.DataCase, async: true

  import Devspot.Factory

  alias Devspot.{Error, Experience}
  alias Devspot.Experiences.Get

  describe "all_by_user_id/1" do
    test "When there is an user with the given id, returns all experiences" do
      user_id = "b721fcad-e6e8-4e8f-910b-6911f2158b4a"

      insert(:user)

      insert(:experience)

      insert(%Experience{
        user_id: user_id,
        company: "Nubank",
        role: "Closure Backend Developer",
        start: ~D[2010-11-30],
        end: ~D[2013-10-30]
      })

      response = Get.all_by_user_id(user_id)

      assert {
               :ok,
               [
                 %Experience{},
                 %Experience{}
               ]
             } = response
    end

    test "When there is no an user with the given id, returns an error" do
      user_id = "b721fcad-e6e8-4e8f-910b-6911f2158b4a"

      response = Get.all_by_user_id(user_id)

      expected_response = {:error, %Error{result: "User not found", status: :not_found}}

      assert response == expected_response
    end
  end

  describe "experience_by_id/1" do
    test "When there is an experience with the given id, returns the experience" do
      insert(:user)
      %Experience{id: experience_id} = insert(:experience)

      response = Get.experience_by_id(experience_id)

      assert {:ok, %Experience{}} = response
    end

    test "When there is no an experience with the given id, returns an error" do
      experience_id = "b721fcad-e6e8-4e8f-910b-6911f2158b4a"

      response = Get.experience_by_id(experience_id)

      expected_response =
        {:error, %Devspot.Error{result: "Experience not found", status: :not_found}}

      assert response == expected_response
    end
  end
end
