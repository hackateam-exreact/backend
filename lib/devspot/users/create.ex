defmodule Devspot.Users.Create do
  alias Devspot.User
  alias Devspot.Repo

  @doc """
  Inserts an user into the database.

  ## Examples

      iex> user_params = %{email: "maiqui@email.com", password: "123456", first_name: "Maiqui", last_name: "Tomé", contact: "54 9 9191-9292", location: "Flores da Cunha/RS", status: "Open"}

      iex> {:ok, %Devspot.User{}} = Devspot.Users.Create.call(user_params)

  """
  @spec call(map()) :: {:ok, %User{}} | {:error, %Ecto.Changeset{}}
  def call(%{} = params) do
    params
    |> User.changeset()
    |> Repo.insert()
  end
end
