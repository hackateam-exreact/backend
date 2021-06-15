defmodule Devspot.Repo do
  use Ecto.Repo,
    otp_app: :devspot,
    adapter: Ecto.Adapters.Postgres
end
