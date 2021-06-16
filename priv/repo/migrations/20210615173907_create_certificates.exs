defmodule Devspot.Repo.Migrations.CreateCertificates do
  use Ecto.Migration

  def change do
    create table(:certificates, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :url, :string
      add :user_id, references(:users, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:certificates, [:user_id])
  end
end
