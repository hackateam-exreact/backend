defmodule DevspotWeb.ProjectsView do
  use DevspotWeb, :view

  alias Devspot.Project

  def render("create.json", %{project: %Project{github_projects: github_projects} = project}) do
    %{
      message: "Project created!",
      id: project.id,
      user_id: project.user_id,
      name: project.name,
      github_projects: github_projects
    }
  end

  def render("projects_list.json", %{projects_list: projects_list}) do
    list =
      Enum.map(projects_list, fn project ->
        %{
          id: project.id,
          name: project.name,
          user_id: project.user_id,
          github_projects: project.github_projects
        }
      end)

    %{
      list_of_projects: list
    }
  end
end
