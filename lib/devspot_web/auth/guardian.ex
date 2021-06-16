defmodule DevspotWeb.Auth.Guardian do
  use Guardian, otp_app: :devspot

  alias Devspot.User

  alias Devspot.Error

  def subject_for_token(%User{id: id}, _claims) do
    {:ok, id}
  end

  def resource_from_claims(claims) do
    claims
    |> Map.get("sub")
    |> Devspot.get_user_by_id()
  end

  def retrieve_user_id_from_connection(conn) do
    [token] = Plug.Conn.get_req_header(conn, "authorization")
    token = String.replace(token, "Bearer ", "")
    {:ok, %{id: user_id}, _claims} = __MODULE__.resource_from_token(token)
    user_id
  end

  def authenticate(%{"id" => user_id, "password" => password}) do
    with {:ok, %User{password_hash: hash} = user} <- Devspot.get_user_by_id(user_id),
         true <- Pbkdf2.verify_pass(password, hash),
         {:ok, token, _claims} <- encode_and_sign(user) do
      {:ok, token}
    else
      false -> {:error, Error.build(:unauthorized, "Please verify your credentials")}
      error -> error
    end
  end

  def authenticate(_), do: {:error, Error.build(:bad_request, "Invalid or missing params")}
end
