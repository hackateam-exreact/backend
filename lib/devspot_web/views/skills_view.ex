defmodule DevspotWeb.SkillsView do
  use DevspotWeb, :view

  def render("index.json", %{skills: skills}) do
    %{
      skills: skills
    }
  end

  def render("create.json", %{user_skill: user_skill}) do
    %{
      message: "User skills created!",
      user_skill: user_skill
    }
  end

  def render("user_skills.json", %{user_skills: user_skills}) do
    %{
      user_skills: user_skills
    }
  end
end
