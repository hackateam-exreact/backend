defmodule DevspotWeb.CertificatesController do
  use DevspotWeb, :controller

  alias Devspot.Certificate

  alias DevspotWeb.{Auth.Guardian, FallbackController}

  action_fallback FallbackController

  def create(conn, params) do
    user_id = Guardian.retrieve_user_id_from_connection(conn)
    params = Map.put(params, "user_id", user_id)

    with {:ok, %Certificate{} = certificate} <- Devspot.create_certificate(params) do
      conn
      |> put_status(:created)
      |> render("create.json", certificate: certificate)
    end
  end

  def show(conn, %{"user_id" => user_id}) do
    with {:ok, certificates_list} <- Devspot.get_all_certificates(user_id) do
      conn
      |> put_status(:ok)
      |> render("certificates_list.json", certificates_list: certificates_list)
    end
  end
end
