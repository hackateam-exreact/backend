defmodule Devspot.Experiences.CreateTest do
  use Devspot.DataCase, async: true

  import Devspot.Factory

  alias Devspot.Experiences.Create
  alias Devspot.{Error, Experience}
  alias Ecto.Changeset

  describe "call/1" do
    test "when all params are valid, returns an experience" do
      insert(:user)
      insert(:experience)

      params = build(:experience_params)

      assert {:ok, %Experience{}} = Create.call(params)
    end

    test "when some param is invalid, returns an error" do
      insert(:user)
      insert(:experience)

      params =
        build(:experience_params, %{
          "company" => "",
          "role" => "",
          "start" => "30/30/2011",
          "end" => "30/30/2012"
        })

      assert {:error,
              %Error{
                result: %Changeset{
                  action: :insert,
                  changes: %{user_id: "b721fcad-e6e8-4e8f-910b-6911f2158b4a"},
                  errors: [
                    company: {"can't be blank", [validation: :required]},
                    role: {"can't be blank", [validation: :required]},
                    start: {"is invalid", [type: :date, validation: :cast]},
                    end: {"is invalid", [type: :date, validation: :cast]}
                  ],
                  valid?: false
                },
                status: :bad_request
              }} = Create.call(params)
    end
  end
end
