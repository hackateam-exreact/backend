defmodule DevspotWeb.CertificatesControllerTest do
  use DevspotWeb.ConnCase, async: true

  import Devspot.Factory

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
end
