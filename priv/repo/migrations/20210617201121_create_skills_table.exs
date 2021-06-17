defmodule Devspot.Repo.Migrations.CreateSkillsTable do
  use Ecto.Migration

  def change do
    create table(:skills) do
      add(:name, :string)
      add(:image_url, :string)

      timestamps()
    end
  end
end
