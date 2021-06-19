defmodule Devspot.Articles.Create do
  alias Devspot.Article
  alias Devspot.{Error, Repo, User}

  @doc """
  Inserts an article into the database.

  ## Examples

    iex> article_params = %{"user_id" => "6721ba81-00ce-46cd-b26c-973989b61c55", "url" => "https://dev.to/maiquitome/o-ciclo-de-vida-do-request-no-phoenix-53e7", "title" => "O Ciclo de Vida do Request no Phoenix"}

    iex> {:ok, %Devspot.Article{}} = Devspot.Articles.Create.call(article_params)

  """
  @spec call(map()) ::
          {:error, %Error{result: String.t(), status: :not_found}}
          | {:error, %Error{result: %Ecto.Changeset{}, status: :bad_request}}
          | {:ok, %Article{}}
  def call(%{"user_id" => user_id} = params) do
    with {:ok, %User{}} <- Devspot.get_user_by_id(user_id) do
      params
      |> Article.changeset()
      |> Repo.insert()
      |> handle_insert()
    end
  end

  defp handle_insert({:ok, %Article{}} = result), do: result

  defp handle_insert({:error, changeset}) do
    {:error, Error.build(:bad_request, changeset)}
  end
end
