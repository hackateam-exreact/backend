defmodule DevspotWeb.UsersControllerTest do
  use DevspotWeb.ConnCase, async: true

  import Devspot.Factory

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
end
