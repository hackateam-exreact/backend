defmodule Devspot.Certificates.Create do
  alias Devspot.Certificate
  alias Devspot.{Error, Repo, User}

  @doc """
  Inserts a certificate into the database.

  ## Examples

    iex> certificate_params = %{"user_id" => "6721ba81-00ce-46cd-b26c-973989b61c55", "url" => "https://balta.io/certificados/1fd6a983-6805-4bb6-8cbd-274e5364d9db", "title" => "Começando com Angular com carga horária de 2 horas"}

    iex> {:ok, %Devspot.Certificate{}} = Devspot.Certificates.Create.call(certificate_params)

  """
  @spec call(map()) ::
          {:error, %Error{result: String.t(), status: :not_found}}
          | {:error, %Error{result: %Ecto.Changeset{}, status: :bad_request}}
          | {:ok, %Certificate{}}
  def call(%{"user_id" => user_id} = params) do
    with {:ok, %User{}} <- Devspot.get_user_by_id(user_id) do
      params
      |> Certificate.changeset()
      |> Repo.insert()
      |> handle_insert()
    end
  end

  defp handle_insert({:ok, %Certificate{}} = result), do: result

  defp handle_insert({:error, changeset}) do
    {:error, Error.build(:bad_request, changeset)}
  end
end
