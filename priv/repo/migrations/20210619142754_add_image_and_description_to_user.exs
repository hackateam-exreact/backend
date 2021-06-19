defmodule Devspot.Repo.Migrations.AddImageAndDescriptionToUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :description, :text
      add :image_url, :string
    end
  end
end
