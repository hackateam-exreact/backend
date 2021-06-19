defmodule Devspot.Repo.Migrations.CreateExperiences do
  use Ecto.Migration

  def change do
    create table(:experiences, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :company, :string
      add :role, :string
      add :start, :date
      add :end, :date
      add :user_id, references(:users, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:experiences, [:user_id])
  end
end
