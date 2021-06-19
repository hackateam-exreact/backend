defmodule Devspot.Skills.Get do
  import Ecto.Query

  alias Devspot.{Error, Repo, Skill, UserSkill}

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

  def search_user_by_skills(skill_str) when is_binary(skill_str) do
    [head | tail] = String.split(skill_str)

    acc = generate_acc(head)

    Enum.reduce(tail, acc, fn skill, acc -> filter_user_by_skills(skill, acc) end)
    |> Enum.map(fn {_key, user} -> user end)
  end

  def search_user_by_skills(_skill_str), do: {:error, Error.build(:bad_request, "Not a string")}

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
