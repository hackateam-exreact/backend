defmodule Devspot.Articles.CreateTest do
  use Devspot.DataCase, async: true

  import Devspot.Factory
  alias Devspot.{Article, Error}
  alias Devspot.Articles.Create

  describe "call/1" do
    test "when all params are valid, returns an article" do
      insert(:user)

      params = build(:article_params)

      assert {:ok, %Article{}} = Create.call(params)
    end

    test "when some param is invalid, returns an error" do
      insert(:user)

      params = build(:article_params, %{"url" => "", "title" => ""})

      assert {
               :error,
               %Error{
                 result: %Ecto.Changeset{
                   action: :insert,
                   changes: %{user_id: "b721fcad-e6e8-4e8f-910b-6911f2158b4a"},
                   errors: [
                     url: {"can't be blank", [validation: :required]},
                     title: {"can't be blank", [validation: :required]}
                   ],
                   valid?: false
                 },
                 status: :bad_request
               }
             } = Create.call(params)
    end

    test "when there is no an user with the given id, returns an error" do
      params = build(:article_params)

      expected_response = {:error, %Error{result: "User not found", status: :not_found}}

      response = Create.call(params)

      assert response == expected_response
    end
  end
end
