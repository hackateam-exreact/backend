defmodule Devspot.GithubProject do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :name, :project_id, :url]}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "github_projects" do
    field :url, :string
    field :name, :string
    belongs_to :project, Devspot.Project

    timestamps()
  end

  def changeset(attrs) do
    changeset(%__MODULE__{}, attrs)
  end

  @doc false
  def changeset(github_project, attrs) do
    github_project
    |> cast(attrs, [:project_id, :name, :url])
    |> validate_required([:project_id, :name, :url])
  end
end
