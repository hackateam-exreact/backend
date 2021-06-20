defmodule Devspot.Project do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :user_id, :name]}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "projects" do
    field :name, :string

    belongs_to :user, Devspot.User
    has_many :github_projects, Devspot.GithubProject

    timestamps()
  end

  def changeset(attrs) do
    changeset(%__MODULE__{}, attrs)
  end

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, [:user_id, :name])
    |> validate_required([:user_id, :name])
  end
end
