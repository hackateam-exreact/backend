defmodule DevspotWeb.CertificatesController do
  use DevspotWeb, :controller

  alias Devspot.Certificate

  alias DevspotWeb.FallbackController

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %Certificate{} = certificate} <- Devspot.create_certificate(params) do
      conn
      |> put_status(:created)
      |> render("create.json", certificate: certificate)
    end
  end
end
