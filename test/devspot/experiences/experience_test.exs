defmodule Devspot.ExperienceTest do
  use Devspot.DataCase, async: true

  import Devspot.Factory

  alias Devspot.Experience
  alias Ecto.Changeset

  describe "changeset/1" do
    test "when all params are valid, returns a valid changeset" do
      params = build(:experience_params)

      response = Experience.changeset(params)

      assert %Changeset{
               changes: %{
                 company: "Stone",
                 end: ~D[2012-12-30],
                 role: "Elixir Backend Developer",
                 start: ~D[2011-11-30],
                 user_id: "b721fcad-e6e8-4e8f-910b-6911f2158b4a"
               },
               errors: [],
               valid?: true
             } = response
    end

    test "when some param is invalid, returns an invalid changeset" do
      params = %{
        "user_id" => "",
        "company" => "",
        "role" => "",
        "start" => "30/30/2011",
        "end" => "30/30/2012"
      }

      response = Experience.changeset(params)

      assert %Ecto.Changeset{
               action: nil,
               changes: %{},
               errors: [
                 user_id: {"can't be blank", [validation: :required]},
                 company: {"can't be blank", [validation: :required]},
                 role: {"can't be blank", [validation: :required]},
                 start: {"is invalid", [type: :date, validation: :cast]},
                 end: {"is invalid", [type: :date, validation: :cast]}
               ]
             } = response
    end
  end
end
