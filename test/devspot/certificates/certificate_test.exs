defmodule Devspot.CertificateTest do
  use Devspot.DataCase, async: true

  import Devspot.Factory

  alias Ecto.Changeset
  alias Devspot.Certificate

  describe "changeset/1" do
    test "when all params are valid, returns a valid changeset" do
      params = build(:certificate_params)

      response = Certificate.changeset(params)

      assert %Changeset{
               changes: %{
                 title: "Começando com Angular com carga horária de 2 horas",
                 url: "https://balta.io/certificados/1fd6a983-6805-4bb6-8cbd-274e5364d9db",
                 user_id: "b721fcad-e6e8-4e8f-910b-6911f2158b4a"
               },
               errors: [],
               valid?: true
             } = response
    end

    test "when some param is invalid, returns an error" do
      params = %{"user_id" => "", "title" => "", "url" => ""}

      response = Certificate.changeset(params)

      assert %Changeset{
               errors: [
                 url: {"can't be blank", [validation: :required]},
                 user_id: {"can't be blank", [validation: :required]},
                 title: {"can't be blank", [validation: :required]}
               ]
             } = response
    end
  end
end
