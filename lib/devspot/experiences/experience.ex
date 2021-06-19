defmodule Devspot.Experience do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:user_id, :id, :company, :role, :start, :end]}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "experiences" do
    field :company, :string
    field :end, :date
    field :role, :string
    field :start, :date

    belongs_to :user, Devspot.User

    timestamps()
  end

  def changeset(attrs) do
    changeset(%__MODULE__{}, attrs)
  end

  @doc false
  def changeset(experience, %{"start" => start_date, "end" => end_date} = attrs) do
    start_date = string_to_date(start_date)
    end_date = string_to_date(end_date)

    attrs = Map.put(attrs, "start", start_date)
    attrs = Map.put(attrs, "end", end_date)

    experience
    |> cast(attrs, [:user_id, :company, :role, :start, :end])
    |> validate_required([:user_id, :company, :role, :start, :end])
  end

  defp string_to_date(string_date) do
    [day, month, year] = String.split(string_date, "/")

    day = String.to_integer(day)
    month = String.to_integer(month)
    year = String.to_integer(year)

    year
    |> Date.new(month, day)
    |> validate_date()
  end

  defp validate_date({:ok, date}), do: date
  defp validate_date({:error, error_message}), do: error_message
end
