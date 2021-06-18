defmodule Devspot.Skills.Create do
  alias Devspot.Skill
  alias Devspot.{Error, Repo, User, UserSkill}

  def call(params) do
    params
    |> Skill.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  def for_user_skill(%{"user_id" => user_id, "skill_id" => skill_id} = params) do
    with {:ok, %User{}} <- Devspot.get_user_by_id(user_id),
         {:ok, %Skill{}} <- Devspot.get_skill_by_id(skill_id) do
      params
      |> UserSkill.changeset()
      |> Repo.insert()
      |> handle_user_skill_insert()
    else
      error -> {:error, Error.build(:bad_request, error)}
    end
  end

  defp handle_user_skill_insert({:ok, %UserSkill{} = user_skill}) do
    {:ok, Repo.preload(user_skill, [:skill])}
  end

  defp handle_user_skill_insert({:error, error}) do
    {:error, Error.build(:bad_request, error)}
  end

  defp handle_insert({:ok, %Skill{}} = result), do: result

  defp handle_insert({:error, result}) do
    {:error, Error.build(:bad_request, result)}
  end
end
