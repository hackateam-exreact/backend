defmodule Devspot.Skills.SkillSearch do
  import Ecto.Query

  alias Devspot.{Repo, Skill, UserSkill}

  def search_user_by_skills(first_skill, other_skills) do
    with %{} = acc <- generate_acc(first_skill) do
      Enum.reduce(other_skills, acc, fn skill, acc -> filter_user_by_skills(skill, acc) end)
      |> Enum.map(fn {_key, user} -> user end)
    else
      [] -> []
    end
  end

  defp filter_user_by_skills(skill, acc) do
    get_by_skill_name(skill)
    |> build_skill_map()
    |> intersect_maps(acc)
  end

  defp intersect_maps(map_1, map_2) do
    keys_1 = Map.keys(map_1)
    keys_2 = Map.keys(map_2)

    intersection = Enum.filter(keys_1, fn key -> Enum.member?(keys_2, key) end)

    set_diff = keys_1 -- intersection

    Map.drop(map_1, set_diff)
  end

  defp generate_acc(skill) do
    case get_by_skill_name(skill) do
      [] -> []
      [%UserSkill{} | _tail] = user_skill_list -> build_skill_map(user_skill_list)
    end
  end

  defp get_by_skill_name(skill_name) do
    query =
      from user_skill in UserSkill,
        join: skill in Skill,
        on: skill.id == user_skill.skill_id,
        where: skill.name == ^skill_name,
        preload: [skill: skill]

    query
    |> Repo.all()
    |> Repo.preload([:skill, :user])
  end

  defp build_skill_map(user_skill_list) do
    Enum.reduce(user_skill_list, %{}, fn user_skill, acc ->
      Map.put(acc, user_skill.user.id, user_skill.user)
    end)
  end
end
