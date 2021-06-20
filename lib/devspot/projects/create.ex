defmodule Devspot.Projects.Create do
  alias Devspot.Projects.Get, as: ProjectsGet
  alias Devspot.GithubProjects.Create, as: GithubProjectsCreate
  alias Devspot.{Error, Project, Repo, User}

  @doc """
  Inserts a project into the database.

  ## Examples

    iex> project_params = %{
      "user_id" => "6721ba81-00ce-46cd-b26c-973989b61c55",
      "name" => "devspot",
      "github_projects" =>
      [
        %{
          "name" => "API",
          "url" => "example.com"
        },
        %{
          "name" => "Mobile",
          "url" => "example2.com"
        },
        %{
          "name" => "Teste",
          "url" => "example3.com"
        }
      ]
    }

    iex> Devspot.Projects.Create.call(project_params)

  """
  @spec call(map()) ::
          {:error, %Error{result: String.t(), status: :not_found}}
          | {:error, %Error{result: %Ecto.Changeset{}, status: :bad_request}}
          | {:ok, %Project{}}
  def call(%{"user_id" => user_id} = params) do
    with {:ok, %User{}} <- Devspot.get_user_by_id(user_id) do
      %{
        "user_id" => user_id,
        "name" => project_name,
        "github_projects" => github_projects
      } = params

      %{user_id: user_id, name: project_name}
      |> Project.changeset()
      |> Repo.insert()
      |> handle_project_insert()
      |> insert_github_projects(github_projects)
    end
  end

  defp insert_github_projects({:ok, %Project{id: project_id}}, github_projects) do
    Enum.each(github_projects, fn github_projects ->
      %{"url" => url, "name" => project_name} = github_projects

      %{"url" => url, "name" => project_name, "project_id" => project_id}
      |> GithubProjectsCreate.call()
    end)

    ProjectsGet.project_with_github_projects(project_id)
  end

  defp insert_github_projects({:error, %Error{}} = error, _github_projects), do: error

  defp handle_project_insert({:ok, %Project{}} = result), do: result

  defp handle_project_insert({:error, changeset}) do
    {:error, Error.build(:bad_request, changeset)}
  end
end
