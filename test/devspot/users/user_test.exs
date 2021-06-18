defmodule Devspot.UserTest do
  use Devspot.DataCase, async: true

  import Devspot.Factory

  alias Devspot.User
  alias Ecto.Changeset

  describe "changeset/2" do
    test "when all params are valid, returns a valid changeset" do
      params = build(:user_params)

      response = User.changeset(params)

      assert %Changeset{
               changes: %{
                 contact: "54 9 9191-9292",
                 email: "maiqui@email.com",
                 first_name: "Maiqui",
                 last_name: "Tomé",
                 location: "Flores da Cunha/RS",
                 password: "123456",
                 password_hash: _password_hash,
                 status: :Open
               },
               valid?: true
             } = response
    end

    test "when updating a changeset, returns a valid changeset with the given changes" do
      params = build(:user_params)

      update_params = %{first_name: "Mike"}

      changeset_with_current_data = User.changeset(params)

      response = User.changeset(changeset_with_current_data, update_params)

      assert %Changeset{
               changes: %{
                 contact: "54 9 9191-9292",
                 email: "maiqui@email.com",
                 first_name: "Mike",
                 last_name: "Tomé",
                 location: "Flores da Cunha/RS",
                 password: "123456",
                 password_hash: _password_hash,
                 status: :Open
               },
               valid?: true
             } = response
    end

    test "when there are some error, returns an invalid changeset" do
      params = build(:user_params, %{"password" => "123", "email" => "email.com"})

      response = User.changeset(params)

      expected_response = %{
        email: ["has invalid format"],
        password: ["should be at least 6 character(s)"]
      }

      assert errors_on(response) == expected_response
    end
  end
end
