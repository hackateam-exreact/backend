defmodule Devspot.Skills.Get do
  import Ecto.Query

  alias Devspot.{Error, Repo, Skill, Skills.SkillSearch, UserSkill}

  def all do
    {:ok, Repo.all(Skill)}
  end

  def by_id(skill_id) do
    case Repo.get(Skill, skill_id) do
      nil -> {:error, Error.build(:not_found, "Skill not found")}
      skill -> {:ok, skill}
    end
  end

  def user_skill_by_user_id(user_id) do
    query = from user_skill in UserSkill, where: user_skill.user_id == ^user_id

    query
    |> Repo.all()
    |> Repo.preload([:skill])
    |> handle_get()
  end

  defp handle_get(skills) when is_list(skills), do: {:ok, skills}
  defp handle_get(error), do: {:error, Error.build(:bad_request, error)}

  def get_user_with_skills(skill_str) when is_binary(skill_str) do
    [head | tail] = String.split(skill_str)

    SkillSearch.search_user_by_skills(head, tail)
  end
end
