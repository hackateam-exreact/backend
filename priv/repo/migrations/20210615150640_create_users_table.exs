defmodule Devspot.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :password_hash, :string
      add :first_name, :string
      add :last_name, :string
      add :contact, :string
      add :location, :string
      add :status, :status_type

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
