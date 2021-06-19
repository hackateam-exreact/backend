defmodule DevspotWeb.ArticlesController do
  use DevspotWeb, :controller

  alias Devspot.Article

  alias DevspotWeb.{Auth.Guardian, FallbackController}

  action_fallback FallbackController

  def create(conn, params) do
    user_id = Guardian.retrieve_user_id_from_connection(conn)
    params = Map.put(params, "user_id", user_id)

    with {:ok, %Article{} = article} <- Devspot.create_article(params) do
      conn
      |> put_status(:created)
      |> render("create.json", article: article)
    end
  end

  def show(conn, %{"user_id" => user_id}) do
    with {:ok, articles_list} <- Devspot.get_all_articles(user_id) do
      conn
      |> put_status(:ok)
      |> render("articles_list.json", articles_list: articles_list)
    end
  end

  def delete(conn, %{"id" => article_id}) do
    user_id = Guardian.retrieve_user_id_from_connection(conn)

    with {:ok, %Article{}} <- Devspot.delete_article(article_id, user_id) do
      conn
      |> put_status(:no_content)
      |> text("")
    end
  end
end
