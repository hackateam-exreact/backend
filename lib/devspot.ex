defmodule Devspot do
  @moduledoc """
  Devspot keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  alias Devspot.Certificates.Create, as: CreateCertificate
  alias Devspot.Experiences.Create, as: CreateExperience
  alias Devspot.Experiences.Get, as: GetExperience
  alias Devspot.Users.Create, as: CreateUser
  alias Devspot.Users.Get, as: GetUser

  @doc """
  Inserts an user into the database.

  ## Examples

      iex> user_params = %{email: "maiqui@email.com", password: "123456", first_name: "Maiqui", last_name: "Tomé", contact: "54 9 9191-9292", location: "Flores da Cunha/RS", status: "Open"}

      iex> {:ok, %Devspot.User{}} = Devspot.create_user(user_params)

  """
  defdelegate create_user(params),
    to: CreateUser,
    as: :call

  @doc """
  Gets an user from the database.

  ## Examples

      iex> user_params = %{email: "maiqui@email.com", password: "123456", first_name: "Maiqui", last_name: "Tomé", contact: "54 9 9191-9292", location: "Flores da Cunha/RS", status: "Open"}

      iex> {:ok, %Devspot.User{} = user} = Devspot.create_user(user_params)

      iex> {:ok, %Devspot.User{}} = Devspot.get_user_by_id(user.id)

  """
  defdelegate get_user_by_id(id),
    to: GetUser,
    as: :by_id

  @doc """
  Gets an user from the database with email.

  ## Examples

      iex> user_params = %{email: "maiqui@email.com", password: "123456", first_name: "Maiqui", last_name: "Tomé", contact: "54 9 9191-9292", location: "Flores da Cunha/RS", status: "Open"}

      iex> {:ok, %Devspot.User{} = user} = Devspot.create_user(user_params)

      iex> {:ok, %Devspot.User{}} = Devspot.get_user_by_email(user.email)

  """
  defdelegate get_user_by_email(email),
    to: GetUser,
    as: :by_email

  @doc """
  Inserts a certificate into the database.

  ## Examples

    iex> certificate_params = %{"user_id" => "6721ba81-00ce-46cd-b26c-973989b61c55", "url" => "https://balta.io/certificados/1fd6a983-6805-4bb6-8cbd-274e5364d9db", "title" => "Começando com Angular com carga horária de 2 horas"}

    iex> {:ok, %Devspot.Certificate{}} = Devspot.create_certificate(certificate_params)
  """
  defdelegate create_certificate(params),
    to: CreateCertificate,
    as: :call

  @doc """
  Inserts an experience into the database.

  ## Examples

    iex> experience_params = %{
      "user_id" => "6721ba81-00ce-46cd-b26c-973989b61c55",
      "company" => "Rocketseat",
      "end" => "30/12/2012",
      "role" => "Educator",
      "start" => "30/11/2011"
    }

    iex> {:ok, %Devspot.Experience{}} = Devspot.create_experience(experience_params)

  """
  defdelegate create_experience(params),
    to: CreateExperience,
    as: :call


  @doc """
  Gets all experiences by user in the database.

  ## Examples

      iex> user_id = "56f9a803-bdb3-4179-b73e-588d1884ffa2"

      iex> {:ok, schema_list} = Devspot.get_all_experiences(user_id)

  """
  defdelegate get_all_experiences(user_id),
    to: GetExperience,
    as: :all_by_user_id
end
