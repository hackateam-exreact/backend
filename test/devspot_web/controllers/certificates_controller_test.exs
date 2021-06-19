defmodule DevspotWeb.CertificatesControllerTest do
  use DevspotWeb.ConnCase, async: true

  import Devspot.Factory

  alias Devspot.Certificate
  alias DevspotWeb.Auth.Guardian, as: AuthGuardian

  describe "create/2" do
    test "when all params are valid, creates a certificate", %{conn: conn} do
      user = insert(:user)
      {:ok, token, _claims} = AuthGuardian.encode_and_sign(user)

      conn = put_req_header(conn, "authorization", "Bearer #{token}")

      params = %{
        "url" => "https://balta.io/certificados/1fd6a983-6805-4bb6-8cbd-274e5364d9db",
        "title" => "Começando com Angular com carga horária de 2 horas"
      }

      response =
        conn
        |> post(Routes.certificates_path(conn, :create, params))
        |> json_response(:created)

      assert %{
               "certificate" => %{
                 "title" => "Começando com Angular com carga horária de 2 horas",
                 "url" => "https://balta.io/certificados/1fd6a983-6805-4bb6-8cbd-274e5364d9db",
                 "user_id" => "b721fcad-e6e8-4e8f-910b-6911f2158b4a"
               },
               "message" => "Certificate created!"
             } = response
    end
  end

  describe "show/2" do
    test "When there is an user with the given id, returns all certificates", %{conn: conn} do
      user_id = "b721fcad-e6e8-4e8f-910b-6911f2158b4a"

      insert(:user)
      insert(:certificate)
      insert(:certificate, title: "Segundo Curso")

      response =
        conn
        |> get(Routes.certificates_path(conn, :show, user_id))
        |> json_response(:ok)

      assert %{
               "list_of_certificates" => [
                 %{
                   "id" => _id1,
                   "title" => _title1,
                   "url" => _url1,
                   "user_id" => _user_id1
                 },
                 %{
                   "id" => _id2,
                   "title" => _title2,
                   "url" => _url2,
                   "user_id" => _user_id2
                 }
               ]
             } = response
    end

    test "When there is no an user with the given id, returns an error", %{conn: conn} do
      user_id = "b721fcad-e6e8-4e8f-910b-6911f2158b4a"

      response =
        conn
        |> get(Routes.certificates_path(conn, :show, user_id))
        |> json_response(:not_found)

      expected_response = %{"message" => "User not found"}

      assert response == expected_response
    end
  end

  describe "delete/2" do
    test "when there is a certificate with the given id, deletes the certificate", %{conn: conn} do
      insert(:user)
      %Certificate{id: certificate_id} = insert(:certificate)

      response =
        conn
        |> delete(Routes.certificates_path(conn, :delete, certificate_id))
        |> response(:no_content)

      expected_response = ""

      assert response == expected_response
    end

    test "when there is no a certificate with the given id, returns an error", %{conn: conn} do
      certificate_id = "b721fcad-e6e8-4e8f-910b-6911f2158b4a"

      response =
        conn
        |> delete(Routes.certificates_path(conn, :delete, certificate_id))
        |> json_response(:not_found)

      expected_response = %{"message" => "Certificate not found"}

      assert response == expected_response
    end
  end
end
