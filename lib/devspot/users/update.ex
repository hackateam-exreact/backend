defmodule Devspot.Users.Update do
  alias Devspot.{Error, Repo, User}
  alias Ecto.Changeset

  def call(%{"id" => id} = params) do
    case Repo.get(User, id) do
      nil -> {:error, Error.build_user_not_found_error()}
      user -> do_update(user, params)
    end
  end

  defp do_update(user, params) do
    with %Changeset{valid?: true} = changeset <- User.changeset(user, params) do
      Repo.update(changeset)
    else
      error -> {:error, Error.build(:bad_request, error)}
    end
  end
end
