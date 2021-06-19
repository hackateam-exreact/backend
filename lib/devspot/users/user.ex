defmodule Devspot.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Ecto.Enum

  alias Ecto.Changeset

  alias Devspot.Certificate
  alias Devspot.Experience

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_params [:email, :first_name, :last_name, :password]

  @fields [
    :email,
    :first_name,
    :last_name,
    :location,
    :contact,
    :status,
    :password,
    :description,
    :image_url
  ]

  @update_params @required_params -- [:password]

  @status_types [:Open, :Studying, :Employed]

  @derive {Jason.Encoder,
           only: [
             :id,
             :email,
             :first_name,
             :last_name,
             :location,
             :contact,
             :status,
             :description,
             :image_url
           ]}

  schema "users" do
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :first_name, :string
    field :last_name, :string
    field :contact, :string
    field :location, :string
    field :status, Enum, values: @status_types
    field :description, :string
    field :image_url, :string

    has_many :certificates, Certificate
    has_many :experiences, Experience

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

  def changeset(struct, params) do
    struct
    |> changes(params, @update_params)
  end

  defp changes(struct, params, fields) do
    struct
    |> cast(params, @fields)
    |> validate_required(fields)
    |> validate_length(:password, min: 6)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint([:email])
    |> put_password_hash()
  end

  defp put_password_hash(%Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Pbkdf2.add_hash(password))
  end

  defp put_password_hash(changeset), do: changeset
end
