defmodule Devspot.Skill do
  use Ecto.Schema
  import Ecto.Changeset

  @required_params [:name, :image_url]

  @derive {Jason.Encoder, only: [:name, :image_url]}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "skills" do
    field(:name, :string)
    field(:image_url, :string)

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
