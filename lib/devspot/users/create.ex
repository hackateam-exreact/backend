defmodule Devspot.Users.Create do
  alias Devspot.User
  alias Devspot.{Error, Repo}
  alias Ecto.Changeset

  @doc """
  Inserts an user into the database.

  ## Examples

      iex> user_params = %{email: "maiqui@email.com", password: "123456", first_name: "Maiqui", last_name: "Tomé", contact: "54 9 9191-9292", location: "Flores da Cunha/RS", status: "Open"}

      iex> {:ok, %Devspot.User{}} = Devspot.Users.Create.call(user_params)

  """
  @spec call(map()) ::
          {:ok, %User{}} | {:error, %Error{status: :bad_request, result: %Changeset{}}}
  def call(%{} = params) do
    params
    |> User.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %User{}} = result), do: result

  defp handle_insert({:error, changeset}) do
    {:error, Error.build(:bad_request, changeset)}
  end
end
