defmodule Devspot.Repo.Migrations.CreateStatusType do
  use Ecto.Migration

  def change do
    up_query = "CREATE TYPE status_type AS ENUM ('Open to work', 'Studying', 'Employed')"
    down_query = "DROP TYPE status_type"

    execute(up_query, down_query)
  end
end
