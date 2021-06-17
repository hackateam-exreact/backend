defmodule Devspot.SkillTest do
  use Devspot.DataCase, async: true

  import Devspot.Factory

  alias Devspot.Skill
  alias Ecto.Changeset

  describe "changeset/2" do
    test "when all params are valid, returns a valid changeset" do
      params = build(:skill_params)

      response = Skill.changeset(params)

      assert %Changeset{
               changes: %{
                 image_url: "https://www.lucianopastine.tech/img/about-logos/reactjs.png",
                 name: "React"
               },
               valid?: true
             } = response
    end

    test "when there are some error, returns an invalid changeset" do
      params = %{name: "React"}

      response = Skill.changeset(params)

      expected_response = %{image_url: ["can't be blank"]}

      assert errors_on(response) == expected_response
    end
  end
end
