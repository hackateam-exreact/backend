defmodule Devspot.Repo.Migrations.CreateUserSkillsTable do
  use Ecto.Migration

  def change do
    create table(:user_skills) do
      add :user_id, references(:users, type: :binary_id)
      add :skill_id, references(:skills, type: :binary_id)
      add :abstract, :text

      timestamps()
    end
  end
end
