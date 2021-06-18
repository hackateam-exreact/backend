defmodule Devspot.Experiences.GetTest do
  use Devspot.DataCase, async: true

  import Devspot.Factory

  alias Devspot.{Error, Experience}
  alias Devspot.Experiences.Get
  alias Devspot.User

  describe "all_by_user_id/1" do
    test "When there is an user with the given id, returns all experiences" do
      # USER 1
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
                 %Experience{
                   company: "Stone",
                   end: ~D[2012-12-30],
                   id: _id1,
                   inserted_at: _inserted_at1,
                   role: "Elixir Backend Developer",
                   start: ~D[2011-11-30],
                   updated_at: _updated_at1,
                   user_id: user_id
                 },
                 %Experience{
                   company: "Nubank",
                   end: ~D[2013-10-30],
                   id: _id2,
                   inserted_at: _inserted_at2,
                   role: "Closure Backend Developer",
                   start: ~D[2010-11-30],
                   updated_at: _updated_at2,
                   user_id: user_id
                 }
               ]
             } = response

      # USER 2
      user_id_2 = "e0791bb0-93b1-4c03-90e8-a30348710f82"

      insert(%User{
        email: "mike@email.com",
        password: "12345678",
        first_name: "Mike",
        last_name: "Wazowski",
        contact: "54 9 9191-9292",
        location: "Monstros SA",
        status: "Open",
        id: user_id_2
      })

      insert(%Experience{
        user_id: user_id_2,
        company: "Nubank",
        role: "Closure Backend Developer",
        start: ~D[2010-11-30],
        end: ~D[2013-10-30]
      })

      response = Get.all_by_user_id(user_id_2)

      assert {
               :ok,
               [
                 %Experience{
                   company: "Nubank",
                   end: ~D[2013-10-30],
                   id: _id3,
                   inserted_at: _inserted_at3,
                   role: "Closure Backend Developer",
                   start: ~D[2010-11-30],
                   updated_at: _updated_at3,
                   user_id: ^user_id_2
                 }
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
end
