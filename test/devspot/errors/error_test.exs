defmodule Devspot.ErrorTest do
  use Devspot.DataCase, async: true

  alias Devspot.Error

  describe "build/2" do
    test "when passing the error params, returns an error struct" do
      response = Error.build(:bad_request, "Params are invalid")

      expected_response = %Error{status: :bad_request, result: "Params are invalid"}

      assert response == expected_response
    end
  end
end
