defmodule Devspot.Users.UpdateTest do
  use Devspot.DataCase

  import Devspot.Factory

  alias Devspot.{Error, User}
  alias Devspot.Users.Update

  describe "call/1" do
    setup do
      %User{id: id} = insert(:user)

      {:ok, id: id}
    end

    test "when all params are valid, returns the updated user", %{id: id} do
      params = %{"id" => id, "location" => "Ubatuba"}

      response = Update.call(params)

      assert {:ok,
              %Devspot.User{
                contact: "54 9 9191-9292",
                description: "bacana",
                email: "maiqui@email.com",
                first_name: "Maiqui",
                id: _id,
                image_url: _url,
                inserted_at: _insert_date,
                last_name: "Tomé",
                location: "Ubatuba",
                status: :Open,
                updated_at: _up_date
              }} = response
    end

    test "when the user doesnt exist, returns an error" do
      id = "5484b227-0f8f-4e84-ab01-41fd7c4c43de"

      params = %{"id" => id, "location" => "Ubatuba"}

      response = Update.call(params)

      expected_response = {:error, Error.build_user_not_found_error()}

      assert expected_response == response
    end
  end
end
