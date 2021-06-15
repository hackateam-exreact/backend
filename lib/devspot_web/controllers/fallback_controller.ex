defmodule DevspotWeb.FallbackController do
  use DevspotWeb, :controller

  alias Devspot.Error
  alias DevspotWeb.ErrorView

  def call(conn, {:error, %Error{status: status, result: result}}) do
    conn
    |> put_status(status)
    |> put_view(ErrorView)
    |> render("error.json", result: result)
  end
end
