defmodule Devspot.UserSkill do
  use Ecto.Schema
  import Ecto.Changeset

  alias Devspot.{Skill, User}

  @required_params [:user_id, :skill_id, :abstract]

  @derive {Jason.Encoder, only: @required_params ++ [:id, :skill]}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "user_skills" do
    field :abstract, :string

    belongs_to :skill, Skill
    belongs_to :user, User

    timestamps()
  end

  def build(changeset) do
    changeset
    |> apply_action(:create)
  end

  def changeset(params) do
    %__MODULE__{}
    |> changes(params, @required_params)
  end

  defp changes(struct, params, fields) do
    struct
    |> cast(params, fields)
    |> validate_required(fields)
  end
end
