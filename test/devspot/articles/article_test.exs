defmodule Devspot.ArticleTest do
  use Devspot.DataCase, async: true

  import Devspot.Factory

  alias Devspot.Article
  alias Ecto.Changeset

  describe "changeset/1" do
    test "when all params are valid, returns a valid changeset" do
      params = build(:article_params)

      response = Article.changeset(params)

      assert %Changeset{
               action: nil,
               changes: %{
                 title: "O Ciclo de Vida do Request no Phoenix",
                 url: "https://dev.to/maiquitome/o-ciclo-de-vida-do-request-no-phoenix-53e7",
                 user_id: "b721fcad-e6e8-4e8f-910b-6911f2158b4a"
               },
               errors: [],
               valid?: true
             } = response
    end

    test "when some param is invalid, returns an error" do
      params = %{"user_id" => "", "title" => "", "url" => ""}

      response = Article.changeset(params)

      assert %Changeset{
               errors: [
                 user_id: {"can't be blank", [validation: :required]},
                 url: {"can't be blank", [validation: :required]},
                 title: {"can't be blank", [validation: :required]}
               ]
             } = response
    end
  end
end
