defmodule Devspot.Skills.GetTest do
  use Devspot.DataCase, async: true

  import Devspot.Factory

  alias Devspot.Skill
  alias Devspot.Skills.Get

  describe "all/0" do
    test "returns all skills" do
      insert(:skill)
      insert(:skill, %{id: "b721fcad-e6e8-4e8f-910b-6911f2158b4c", name: "Elixir"})

      response = Get.all()

      assert {:ok,
              [
                %Skill{
                  id: _id,
                  name: "React",
                  image_url: "https://www.lucianopastine.tech/img/about-logos/reactjs.png",
                  inserted_at: _init_date,
                  updated_at: _up_date
                }
                | _rest
              ]} = response
    end
  end

  describe "by_id/1" do
    test "when there is a skill with the given id, returns the skill" do
      %Skill{id: id} = insert(:skill)

      response = Get.by_id(id)

      assert {:ok,
              %Skill{
                id: _id,
                image_url: "https://www.lucianopastine.tech/img/about-logos/reactjs.png",
                inserted_at: _insert_date,
                name: "React",
                updated_at: _up_date
              }} = response
    end

    test "when there is no skill with the given id, returns an error" do
      response = Get.by_id("b721fcad-e6e8-4e8f-910b-6911f2158b4b")

      assert {:error, %Devspot.Error{result: "Skill not found", status: :not_found}} == response
    end
  end
end
