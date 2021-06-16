defmodule Devspot.Certificate do
  use Ecto.Schema
  import Ecto.Changeset

  alias Devspot.User

  @derive {Jason.Encoder, only: [:user_id, :url, :title]}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "certificates" do
    field :url, :string
    field :title, :string

    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(attrs) do
    changeset(%__MODULE__{}, attrs)
  end

  def changeset(certificate, attrs) do
    certificate
    |> cast(attrs, [:url, :user_id, :title])
    |> validate_required([:url, :user_id, :title])
  end
end
