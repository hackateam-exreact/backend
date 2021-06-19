defmodule Devspot.Experiences.Delete do
  alias Devspot.{Error, Experience, Repo}

  @doc """
  Deletes an experience from the database.

  ## Examples

    * creating an experience

          iex> experience_params = %{
            "user_id" => "6721ba81-00ce-46cd-b26c-973989b61c55",
            "company" => "Rocketseat",
            "end" => "30/12/2012",
            "role" => "Educator",
            "start" => "30/11/2011"
          }

          iex> {:ok, %Devspot.Experience{id: experience_id}} = Devspot.create_experience(experience_params)

    * deleting an experience

          iex> {:ok, %Devspot.Experience{}} = Devspot.Experiences.Delete.call(experience_id)

    * getting the deleted experience

          iex> {:error, %Devspot.Error{}} = Devspot.Experiences.Get.experience_by_id(experience_id)

  """
  @spec call(Ecto.UUID, Ecto.UUID) ::
          {:ok, %Experience{}}
          | {:error, %Error{result: String.t(), status: :not_found}}
  def call(experience_id, user_id) do
    case Repo.get_by(Experience, id: experience_id, user_id: user_id) do
      nil -> {:error, Error.build_experience_not_found_error()}
      experience -> Repo.delete(experience)
    end
  end
end
