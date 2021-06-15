defmodule DevspotWeb.CertificatesView do
  use DevspotWeb, :view

  alias Devspot.Certificate

  def render("create.json", %{certificate: %Certificate{} = certificate}) do
    %{
      message: "Certificate created!",
      certificate: certificate
    }
  end
end
