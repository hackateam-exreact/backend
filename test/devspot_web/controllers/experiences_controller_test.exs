defmodule DevspotWeb.ExperiencesControllerTest do
  use DevspotWeb.ConnCase, async: true

  import Devspot.Factory

  alias DevspotWeb.Auth.Guardian, as: AuthGuardian

  describe "create/2" do
    test "when all params are valid, creates an experience", %{conn: conn} do
      user = insert(:user)
      {:ok, token, _claims} = AuthGuardian.encode_and_sign(user)

      conn = put_req_header(conn, "authorization", "Bearer #{token}")

      params = %{
        "company" => "Stone",
        "role" => "Elixir Backend Developer",
        "start" => "30/11/2011",
        "end" => "30/12/2012"
      }

      response =
        conn
        |> post(Routes.experiences_path(conn, :create, params))
        |> json_response(:created)

      assert %{
               "experience" => %{
                 "company" => "Stone",
                 "end" => "2012-12-30",
                 "id" => _id,
                 "role" => "Elixir Backend Developer",
                 "start" => "2011-11-30",
                 "user_id" => "b721fcad-e6e8-4e8f-910b-6911f2158b4a"
               },
               "message" => "Experience created!"
             } = response
    end
  end

  describe "show/2" do
    test "When there is an user with the given id, returns all experiences", %{conn: conn} do
      user_id = "b721fcad-e6e8-4e8f-910b-6911f2158b4a"

      insert(:user)
      insert(:experience)

      response =
        conn
        |> get(Routes.experiences_path(conn, :show, user_id))
        |> json_response(:ok)

      assert %{
               "list_of_experiences" => [
                 %{
                   "company" => "Stone",
                   "end" => "2012-12-30",
                   "id" => _id,
                   "role" => "Elixir Backend Developer",
                   "start" => "2011-11-30",
                   "user_id" => "b721fcad-e6e8-4e8f-910b-6911f2158b4a"
                 }
               ]
             } = response
    end

    test "When there is no an user with the given id, returns an error", %{conn: conn} do
      user_id = "b721fcad-e6e8-4e8f-910b-6911f2158b4a"

      response =
        conn
        |> get(Routes.experiences_path(conn, :show, user_id))
        |> json_response(:not_found)

      expected_response = %{"message" => "User not found"}

      assert response == expected_response
    end
  end
end
