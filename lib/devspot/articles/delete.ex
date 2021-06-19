defmodule Devspot.Articles.Delete do
  alias Devspot.{Article, Error, Repo}

  @doc """
  Deletes an article from the database.

  ## Examples

    * creating an article

        iex> article_params = %{"user_id" => "6721ba81-00ce-46cd-b26c-973989b61c55", "url" => "https://dev.to/maiquitome/o-ciclo-de-vida-do-request-no-phoenix-53e7", "title" => "O Ciclo de Vida do Request no Phoenix"}

        iex> {:ok, %Devspot.Article{id: article_id}} = Devspot.create_article(article_params)

    * deleting an article

        iex> {:ok, %Devspot.Article{}} = Devspot.delete_article(article_id)

    * getting the deleted article

        iex> {:error, %Devspot.Error{}} = Devspot.Articles.Get.article_by_id(article_id)

  """
  @spec call(Ecto.UUID, Ecto.UUID) ::
          {:ok, %Article{}}
          | {:error, %Error{result: String.t(), status: :not_found}}
  def call(article_id, user_id) do
    case Repo.get_by(Article, id: article_id, user_id: user_id) do
      nil -> {:error, Error.build_article_not_found_error()}
      article -> Repo.delete(article)
    end
  end
end
