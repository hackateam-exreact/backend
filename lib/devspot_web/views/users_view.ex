defmodule DevspotWeb.UsersView do
  use DevspotWeb, :view

  alias Devspot.User

  def render("create.json", %{user: %User{} = user, token: token}) do
    %{
      message: "User created!",
      user: user,
      token: token
    }
  end

  def render("update.json", %{user: %User{} = user}) do
    %{
      message: "User updated!",
      user: user
    }
  end

  def render("user.json", %{user: %User{} = user}), do: %{user: user}

  def render("sign_in.json", %{token: token, user: user}) do
    %{
      token: token,
      user: user
    }
  end
end
