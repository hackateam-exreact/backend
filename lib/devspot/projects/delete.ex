defmodule Devspot.Projects.Delete do
  alias Devspot.{Error, GithubProject, Project, Repo}
  alias Devspot.Projects.Get, as: ProjectGet

  @doc """
  Deletes a project from the database.

  ## Examples

    * creating a project

        iex> project_params = %{"user_id" => "6721ba81-00ce-46cd-b26c-973989b61c55","name" => "Ecommerce"}

        iex> {:ok, %Devspot.Project{user_id: user_id, id: project_id}} = Devspot.create_project(project_params)

    * deleting a project

        iex> {:ok, %Devspot.Project{}} = Devspot.delete_project(project_id, user_id)

    * getting the deleted project

        iex> {:error, %Devspot.Error{}} = Devspot.Projects.Get.project_by_id(project_id)

  """
  @spec call(Ecto.UUID, Ecto.UUID) ::
          {:ok, %Project{}}
          | {:error, %Error{result: String.t(), status: :not_found}}
  def call(project_id, user_id) do
    case Repo.get_by(Project, id: project_id, user_id: user_id) do
      nil -> {:error, Error.build_project_not_found_error()}
      _project -> delete_project_and_github_projects(project_id)
    end
  end

  defp delete_project_and_github_projects(project_id) do
    {:ok, %Project{} = project} = ProjectGet.project_with_github_projects(project_id)

    Enum.each(project.github_projects, fn github_project ->
      Repo.delete(Repo.get(GithubProject, github_project.id))
    end)

    Repo.delete(project)
  end
end
