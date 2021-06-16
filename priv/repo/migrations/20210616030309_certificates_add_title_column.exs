defmodule Devspot.Repo.Migrations.CertificatesAddTitleColumn do
  use Ecto.Migration

  def change do
    alter table(:certificates) do
      add :title, :string
    end
  end
end
