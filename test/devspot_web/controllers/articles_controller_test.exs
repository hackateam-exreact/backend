defmodule DevspotWeb.ArticlesControllerTest do
  use DevspotWeb.ConnCase, async: true

  import Devspot.Factory

  alias Devspot.Article
  alias DevspotWeb.Auth.Guardian, as: AuthGuardian

  describe "create/2" do
    test "when all params are valid, creates an article", %{conn: conn} do
      user = insert(:user)
      {:ok, token, _claims} = AuthGuardian.encode_and_sign(user)

      conn = put_req_header(conn, "authorization", "Bearer #{token}")

      params = %{
        "url" => "https://dev.to/maiquitome/o-ciclo-de-vida-do-request-no-phoenix-53e7",
        "title" => "O Ciclo de Vida do Request no Phoenix"
      }

      response =
        conn
        |> post(Routes.articles_path(conn, :create, params))
        |> json_response(:created)

      assert %{
               "article" => %{
                 "id" => _id,
                 "title" => "O Ciclo de Vida do Request no Phoenix",
                 "url" => "https://dev.to/maiquitome/o-ciclo-de-vida-do-request-no-phoenix-53e7",
                 "user_id" => "b721fcad-e6e8-4e8f-910b-6911f2158b4a"
               },
               "message" => "Article created!"
             } = response
    end
  end

  describe "show/2" do
    test "When there is an user with the given id, returns all articles", %{conn: conn} do
      user_id = "b721fcad-e6e8-4e8f-910b-6911f2158b4a"

      insert(:user)
      insert(:article)
      insert(:article, title: "Segundo Curso")

      response =
        conn
        |> get(Routes.articles_path(conn, :show, user_id))
        |> json_response(:ok)

      assert %{
               "list_of_articles" => [
                 %{
                   "id" => _id1,
                   "title" => _title1,
                   "url" => _url1,
                   "user_id" => _user_id1
                 },
                 %{
                   "id" => _id2,
                   "title" => _title2,
                   "url" => _url2,
                   "user_id" => _user_id2
                 }
               ]
             } = response
    end

    test "When there is no an user with the given id, returns an error", %{conn: conn} do
      user_id = "b721fcad-e6e8-4e8f-910b-6911f2158b4a"

      response =
        conn
        |> get(Routes.articles_path(conn, :show, user_id))
        |> json_response(:not_found)

      expected_response = %{"message" => "User not found"}

      assert response == expected_response
    end
  end

  describe "delete/2" do
    test "when there is an article with the given id, deletes the article", %{conn: conn} do
      insert(:user)
      %Article{id: article_id} = insert(:article)

      response =
        conn
        |> delete(Routes.articles_path(conn, :delete, article_id))
        |> response(:no_content)

      expected_response = ""

      assert response == expected_response
    end

    test "when there is no article with the given id, returns an error", %{conn: conn} do
      article_id = "b721fcad-e6e8-4e8f-910b-6911f2158b4a"

      response =
        conn
        |> delete(Routes.articles_path(conn, :delete, article_id))
        |> json_response(:not_found)

      expected_response = %{"message" => "Article not found"}

      assert response == expected_response
    end
  end
end
