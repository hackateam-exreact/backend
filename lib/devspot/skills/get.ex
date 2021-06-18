defmodule Devspot.Skills.Get do
  alias Devspot.Repo
  alias Devspot.Skill

  def all() do
    {:ok, Repo.all(Skill)}
  end
end
