defmodule Devspot.Skills.Create do
  alias Devspot.Skill
  alias Devspot.{Error, Repo}

  def call(params) do
    params
    |> Skill.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %Skill{}} = result), do: result

  defp handle_insert({:error, result}) do
    {:error, Error.build(:bad_request, result)}
  end
end
