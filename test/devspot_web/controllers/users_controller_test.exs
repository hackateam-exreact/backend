defmodule DevspotWeb.UsersControllerTest do
  use DevspotWeb.ConnCase, async: true

  import Devspot.Factory

  alias Devspot.User

  describe "create/2" do
    test "when all params are valid, creates the user", %{conn: conn} do
      params = build(:user_params)

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:created)

      assert %{
               "message" => "User created!",
               "user" => %{
                 "email" => "maiqui@email.com",
                 "first_name" => "Maiqui",
                 "last_name" => "Tomé",
                 "contact" => "54 9 9191-9292",
                 "location" => "Flores da Cunha/RS",
                 "status" => "Open"
               }
             } = response
    end

    test "when there is some error, returns the error", %{conn: conn} do
      params = %{"name" => "Maiqui Tomé"}

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:bad_request)

      expected_response = %{
        "message" => %{
          "email" => ["can't be blank"],
          "first_name" => ["can't be blank"],
          "last_name" => ["can't be blank"],
          "password" => ["can't be blank"]
        }
      }

      assert response == expected_response
    end
  end

  describe "show/2" do
    test "when the user exists, returns the user", %{conn: conn} do
      user = insert(:user)

      %User{id: id} = user

      response =
        conn
        |> get(Routes.users_path(conn, :show, id))
        |> json_response(:ok)

      assert %{
               "user" => %{
                 "contact" => "54 9 9191-9292",
                 "email" => "maiqui@email.com",
                 "first_name" => "Maiqui",
                 "id" => _id,
                 "last_name" => "Tomé",
                 "location" => "Flores da Cunha/RS",
                 "status" => "Open"
               }
             } = response
    end

    test "when the user doesn't exist, returns an error", %{conn: conn} do
      id = "b721fcad-e6e8-4e8f-910b-6911f2158b4a"

      response =
        conn
        |> get(Routes.users_path(conn, :show, id))
        |> json_response(:not_found)

      assert %{"message" => "User not found"} == response
    end
  end
end
