defmodule Devspot.Experiences.Create do
  alias Devspot.Experience
  alias Devspot.{Error, Repo, User}

  @doc """
  Inserts an experience into the database.

  ## Examples

    iex> experience_params = %{
      "user_id" => "6721ba81-00ce-46cd-b26c-973989b61c55",
      "company" => "Rocketseat",
      "end" => "30/12/2012",
      "role" => "Educator",
      "start" => "30/11/2011"
    }

    iex> {:ok, %Devspot.Experience{}} = Devspot.Experiences.Create.call(experience_params)

  """
  @spec call(map()) ::
          {:error, %Error{result: String.t(), status: :not_found}}
          | {:error, %Error{result: %Ecto.Changeset{}, status: :bad_request}}
          | {:ok, %Experience{}}
  def call(%{"user_id" => user_id} = params) do
    with {:ok, %User{}} <- Devspot.get_user_by_id(user_id) do
      params
      |> Experience.changeset()
      |> Repo.insert()
      |> handle_insert()
    end
  end

  defp handle_insert({:ok, %Experience{}} = result), do: result

  defp handle_insert({:error, changeset}) do
    {:error, Error.build(:bad_request, changeset)}
  end
end
