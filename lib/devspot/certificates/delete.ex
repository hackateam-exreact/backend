defmodule Devspot.Certificates.Delete do
  alias Devspot.{Certificate, Error, Repo}

  @doc """
  Deletes an certificate from the database.

  ## Examples

    * creating a certificate

        iex> certificate_params = %{
            "user_id" => "6721ba81-00ce-46cd-b26c-973989b61c55",
            "url" => "https://balta.io/certificados/1fd6a983-6805-4bb6-8cbd-274e5364d9db",
            "title" => "Começando com Angular com carga horária de 2 horas"
          }

        iex> {:ok, %Devspot.Certificate{id: certificate_id}} = Devspot.create_certificate(certificate_params)

    * deleting a certificate

        iex> {:ok, %Devspot.Certificate{}} = Devspot.delete_certificate(certificate_id)

    * getting the deleted certificate

        iex> {:error, %Devspot.Error{}} = Devspot.Certificates.Get.certificate_by_id(certificate_id)

  """
  @spec call(Ecto.UUID, Ecto.UUID) ::
          {:ok, %Certificate{}}
          | {:error, %Error{result: String.t(), status: :not_found}}
  def call(certificate_id, user_id) do
    case Repo.get_by(Certificate, id: certificate_id, user_id: user_id) do
      nil -> {:error, Error.build_certificate_not_found_error()}
      certificate -> Repo.delete(certificate)
    end
  end
end
