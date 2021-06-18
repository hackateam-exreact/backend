defmodule Devspot.Experiences.Get do
  import Ecto.Query, only: [from: 2]

  alias Devspot.{Error, Experience, User}
  alias Devspot.Repo

  @doc """
  Gets all experiences by user in the database.

  ## Examples

      iex> user_id = "56f9a803-bdb3-4179-b73e-588d1884ffa2"

      iex> {:ok, schema_list} = Devspot.Experiences.Get.all_by_user_id(user_id)

  """
  @spec all_by_user_id(Ecto.UUID) ::
          {:ok, [%Experience{}]}
          | {:error, %Error{status: :not_found, result: String.t()}}
  def all_by_user_id(user_id) do
    with {:ok, %User{}} <- Devspot.get_user_by_id(user_id) do
      query = from ex in Experience,
          join: u in User, on: ex.user_id == u.id,
          where: ex.user_id == ^user_id

      {:ok, Repo.all(query)}
    end
  end
end
