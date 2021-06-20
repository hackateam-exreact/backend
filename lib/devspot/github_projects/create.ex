defmodule Devspot.GithubProjects.Create do
  alias Devspot.{Error, GithubProject, Project, Repo}

  @doc """
  Inserts a github_project into the database.

  ## Examples

    iex> github_project_params = %{"project_id" => "6721ba81-00ce-46cd-b26c-973989b61c55", "name" => "devspot"}

    iex> {:ok, %Devspot.GithubProject{}} = Devspot.Projects.Create.call(github_project_params)

  """
  @spec call(map()) ::
          {:error, %Error{result: String.t(), status: :not_found}}
          | {:error, %Error{result: %Ecto.Changeset{}, status: :bad_request}}
          | {:ok, %GithubProject{}}
  def call(%{"project_id" => project_id} = params) do
    with {:ok, %Project{}} <- Devspot.get_project_by_id(project_id) do
      params
      |> GithubProject.changeset()
      |> Repo.insert()
      |> handle_insert()
    end
  end

  defp handle_insert({:ok, %GithubProject{}} = result), do: result

  defp handle_insert({:error, changeset}) do
    {:error, Error.build(:bad_request, changeset)}
  end
end
