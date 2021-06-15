defmodule Devspot.Users.Get do
  alias Devspot.User
  alias Devspot.Repo

  @doc """
  Gets an user from the database.

  ## Examples

      iex> user_params = %{email: "maiqui@email.com", password: "123456", first_name: "Maiqui", last_name: "Tomé", contact: "54 9 9191-9292", location: "Flores da Cunha/RS", status: "Open"}

      iex> {:ok, %Devspot.User{} = user} = Devspot.create_user(user_params)

      iex> {:ok, %Devspot.User{}} = Devspot.Users.Get.by_id(user.id)

  """
  def by_id(id) do
    case Repo.get(User, id) do
      nil -> {:error, "User not found"}
      user_schema -> {:ok, user_schema}
    end
  end
end
