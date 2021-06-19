defmodule Devspot.Certificates.Get do
  import Ecto.Query, only: [from: 2]

  alias Devspot.{Certificate, Error, User}
  alias Devspot.Repo

  @doc """
  Gets all certificates by user in the database.

  ## Examples

      iex> user_id = "56f9a803-bdb3-4179-b73e-588d1884ffa2"

      iex> {:ok, schema_list} = Devspot.Certificates.Get.all_by_user_id(user_id)

  """
  @spec all_by_user_id(Ecto.UUID) ::
          {:ok, [%Certificate{}]}
          | {:error, %Error{status: :not_found, result: String.t()}}
  def all_by_user_id(user_id) do
    with {:ok, %User{}} <- Devspot.get_user_by_id(user_id) do
      query =
        from ex in Certificate,
          join: u in User,
          on: ex.user_id == u.id,
          where: ex.user_id == ^user_id

      {:ok, Repo.all(query)}
    end
  end

  @doc """
  Gets a certificate by id from the database.

  ## Examples

      iex> certificate_id = "b1533a10-e0c3-42e3-89cd-304fac1e63cf"

      iex> %Devspot.Certificate{} = Devspot.Certificates.Get.certificate_by_id(certificate_id)

  """
  @spec certificate_by_id(Ecto.UUID) ::
          {:ok, %Certificate{}} | {:error, %Error{status: :not_found, result: String.t()}}
  def certificate_by_id(id) do
    case Repo.get(Certificate, id) do
      nil -> {:error, Error.build_certificate_not_found_error()}
      certificate_schema -> {:ok, certificate_schema}
    end
  end
end
