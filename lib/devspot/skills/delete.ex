defmodule Devspot.Skills.Delete do
  alias Devspot.{Error, Repo, UserSkill}

  def for_user_skill(user_skill_id) do
    case Repo.get(UserSkill, user_skill_id) do
      nil -> {:error, Error.build(:not_found, "User skill not found")}
      user_skill -> Repo.delete(user_skill)
    end
  end
end
