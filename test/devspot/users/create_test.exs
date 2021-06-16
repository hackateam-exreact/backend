defmodule Devspot.Users.CreateTest do
  use Devspot.DataCase, async: true

  import Devspot.Factory

  alias Devspot.{Error, User}
  alias Devspot.Users.Create

  describe "call/1" do
    test "when all params are valid, returns the user" do
      params = build(:user_params)

      response = Create.call(params)

      assert {:ok, %User{id: _id, email: "maiqui@email.com"}} = response
    end

    test "when there are invalid params, returns an error" do
      params = build(:user_params, %{"password" => "123", "email" => "email.com"})

      response = Create.call(params)

      expected_response = %{
        password: ["should be at least 6 character(s)"],
        email: ["has invalid format"]
      }

      assert {:error, %Error{result: changeset, status: :bad_request}} = response

      assert errors_on(changeset) == expected_response
    end
  end
end
