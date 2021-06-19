defmodule DevspotWeb.CertificatesView do
  use DevspotWeb, :view

  alias Devspot.Certificate

  def render("create.json", %{certificate: %Certificate{} = certificate}) do
    %{
      message: "Certificate created!",
      certificate: certificate
    }
  end

  def render("certificates_list.json", %{certificates_list: certificates_list}) do
    %{
      list_of_certificates: certificates_list
    }
  end
end
