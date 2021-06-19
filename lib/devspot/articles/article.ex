defmodule Devspot.Article do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :user_id, :url, :title]}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "articles" do
    field :title, :string
    field :url, :string

    belongs_to :user, Devspot.User

    timestamps()
  end

  def changeset(attrs) do
    changeset(%__MODULE__{}, attrs)
  end

  @doc false
  def changeset(article, attrs) do
    article
    |> cast(attrs, [:user_id, :url, :title])
    |> validate_required([:user_id, :url, :title])
  end
end
