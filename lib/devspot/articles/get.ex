defmodule Devspot.Articles.Get do
  import Ecto.Query, only: [from: 2]

  alias Devspot.{Article, Error, Repo, User}

  @doc """
  Gets all articles by user in the database.

  ## Examples

      iex> user_id = "6721ba81-00ce-46cd-b26c-973989b61c55"

      iex> {:ok, schema_list} = Devspot.Articles.Get.all_by_user_id(user_id)

  """
  @spec all_by_user_id(Ecto.UUID) ::
          {:ok, [%Article{}]}
          | {:error, %Error{status: :not_found, result: String.t()}}
  def all_by_user_id(user_id) do
    with {:ok, %User{}} <- Devspot.get_user_by_id(user_id) do
      query =
        from art in Article,
          join: u in User,
          on: art.user_id == u.id,
          where: art.user_id == ^user_id

      {:ok, Repo.all(query)}
    end
  end

  @doc """
  Gets an article by id from the database.

  ## Examples

      iex> article_id = "d8d256d3-9f97-46ce-ad4c-08e1c01f09ad"

      iex> {:ok, %Devspot.Article{}} = Devspot.Articles.Get.article_by_id(article_id)

  """
  @spec article_by_id(Ecto.UUID) ::
          {:ok, %Article{}} | {:error, %Error{status: :not_found, result: String.t()}}
  def article_by_id(id) do
    case Repo.get(Article, id) do
      nil -> {:error, Error.build_article_not_found_error()}
      article_schema -> {:ok, article_schema}
    end
  end
end
