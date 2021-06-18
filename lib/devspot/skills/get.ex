defmodule Devspot.Skills.Get do
  alias Devspot.{Error, Repo, Skill}

  def all() do
    {:ok, Repo.all(Skill)}
  end

  def by_id(skill_id) do
    case Repo.get(Skill, skill_id) do
      nil -> {:error, Error.build(:not_found, "Skill not found")}
      skill -> {:ok, skill}
    end
  end
end
