defmodule DevspotWeb.ArticlesView do
  use DevspotWeb, :view

  alias Devspot.Article

  def render("create.json", %{article: %Article{} = article}) do
    %{
      message: "Article created!",
      article: article
    }
  end

  def render("articles_list.json", %{articles_list: articles_list}) do
    %{
      list_of_articles: articles_list
    }
  end
end
