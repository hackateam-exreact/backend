defmodule Devspot.Skills.Get do
  alias Devspot.Repo
  alias Devspot.Skill

  def all() do
    Repo.all(Skill)
  end
end
