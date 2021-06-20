defmodule Devspot.Repo.Migrations.CreateGithubProjects do
  use Ecto.Migration

  def change do
    create table(:github_projects, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :url, :string
      add :name, :string
      add :project_id, references(:projects, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:github_projects, [:project_id])
  end
end
