defmodule DevspotWeb.SkillsView do
  use DevspotWeb, :view

  def render("index.json", %{skills: skills}) do
    %{
      skills: skills
    }
  end
end
