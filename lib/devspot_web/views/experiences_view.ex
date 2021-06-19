defmodule DevspotWeb.ExperiencesView do
  use DevspotWeb, :view

  alias Devspot.Experience

  def render("create.json", %{experience: %Experience{} = experience}) do
    %{
      message: "Experience created!",
      experience: experience
    }
  end

  def render("experiences_list.json", %{experiences_list: experiences_list}) do
    %{
      list_of_experiences: experiences_list
    }
  end
end
