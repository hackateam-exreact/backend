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
    case User.changeset(user, params) do
      %Changeset{valid?: true} = changeset -> Repo.update(changeset)
      error -> {:error, Error.build(:bad_request, error)}
    end
  end
end
