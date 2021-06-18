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
end
