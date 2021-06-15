defmodule Devspot.Certificates.Create do
  alias Devspot.Certificate
  alias Devspot.Repo

  @doc """
  Inserts a certificate into the database.
  """
  @spec call(%{user_id: Ecto.UUID, url: String.t()}) ::
          {:ok, %Certificate{}} | {:error, %Ecto.Changeset{}}
  def call(params) do
    params
    |> Certificate.changeset()
    |> Repo.insert()
  end
end
