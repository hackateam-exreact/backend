defmodule Devspot.Projects.Get do
  import Ecto.Query, only: [from: 2]

  alias Devspot.{Error, Project, Repo, User}

  @doc """
  Gets all projects by user in the database.

  ## Examples

      iex> user_id = "6721ba81-00ce-46cd-b26c-973989b61c55"

      iex> {:ok, schema_list} = Devspot.Projects.Get.all_by_user_id(user_id)

  """
  @spec all_by_user_id(Ecto.UUID) ::
          {:ok, [%Project{}]}
          | {:error, %Error{status: :not_found, result: String.t()}}
  def all_by_user_id(user_id) do
    with {:ok, %User{}} <- Devspot.get_user_by_id(user_id) do
      query =
        from pro in Project,
          join: u in User,
          on: pro.user_id == u.id,
          where: pro.user_id == ^user_id

      project_list =
        Enum.map(Repo.all(query), fn %Devspot.Project{id: project_id} ->
          {:ok, project} = project_with_github_projects(project_id)

          project
        end)

      {:ok, project_list}
    end
  end

  @doc """
  Gets a project by id from the database.

  ## Examples

      iex> project_id = "ba098e5c-f1dc-462c-8f64-bb7dd98e149c"

      iex> {:ok, %Devspot.Project{}} = Devspot.Projects.Get.project_by_id(project_id)

  """
  @spec project_by_id(Ecto.UUID) ::
          {:ok, %Project{}} | {:error, %Error{status: :not_found, result: String.t()}}
  def project_by_id(id) do
    case Repo.get(Project, id) do
      nil -> {:error, Error.build_project_not_found_error()}
      project_schema -> {:ok, project_schema}
    end
  end

  @spec project_with_github_projects(Ecto.UUID) ::
          {:ok, %Project{}}
          | {:error, %Error{status: :not_found, result: String.t()}}
  def project_with_github_projects(project_id) do
    Repo.get(Project, project_id)
    |> Repo.preload([:github_projects])
    |> handle_get()
  end

  defp handle_get(%Project{} = project), do: {:ok, project}

  defp handle_get(error), do: {:error, Error.build(:bad_request, error)}
end
