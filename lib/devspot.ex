defmodule Devspot do
  @moduledoc """
  Devspot keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  alias Devspot.Articles.Create, as: CreateArticle
  alias Devspot.Articles.Delete, as: DeleteArticle
  alias Devspot.Articles.Get, as: GetArticle
  alias Devspot.Certificates.Create, as: CreateCertificate
  alias Devspot.Certificates.Delete, as: DeleteCertificate
  alias Devspot.Certificates.Get, as: GetCertificate
  alias Devspot.Experiences.Create, as: CreateExperience
  alias Devspot.Experiences.Delete, as: DeleteExperience
  alias Devspot.Experiences.Get, as: GetExperience
  alias Devspot.Users.Create, as: CreateUser
  alias Devspot.Users.Get, as: GetUser
  alias Devspot.Users.Update, as: UpdateUser

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
  Updates an User with the given params

  ## Examples

      iex> user_params = %{email: "maiqui@email.com", password: "123456", first_name: "Maiqui", last_name: "Tomé", contact: "54 9 9191-9292", location: "Flores da Cunha/RS", status: "Open"}

      iex> {:ok, %Devspot.User{} = user} = Devspot.create_user(user_params)

      iex> update_params = %{location: "Salvador BA"}

      iex> {:ok, %Devspot.User{}} = Devspot.update_user(update_params)

  """
  defdelegate update_user(params),
    to: UpdateUser,
    as: :call

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
  Deletes a certificate from the database.

  ## Examples

    * creating a certificate

          iex> certificate_params = %{
            "user_id" => "6721ba81-00ce-46cd-b26c-973989b61c55",
            "url" => "https://balta.io/certificados/1fd6a983-6805-4bb6-8cbd-274e5364d9db",
            "title" => "Começando com Angular com carga horária de 2 horas"
          }

          iex> {:ok, %Devspot.Certificate{id: certificate_id}} = Devspot.create_certificate(certificate_params)

    * deleting a certificate

          iex> {:ok, %Devspot.Certificate{}} = Devspot.delete_certificate(certificate_id)

    * getting the deleted certificate

          iex> {:error, %Devspot.Error{}} = Devspot.Certificates.Get.certificate_by_id(certificate_id)

  """
  defdelegate delete_certificate(certificate_id),
    to: DeleteCertificate,
    as: :call

  @doc """
  Gets all certificates by user in the database.

  ## Examples

      iex> user_id = "56f9a803-bdb3-4179-b73e-588d1884ffa2"

      iex> {:ok, schema_list} = Devspot.get_all_certificates(user_id)

  """
  defdelegate get_all_certificates(user_id),
    to: GetCertificate,
    as: :all_by_user_id

  @doc """
  Gets a certificate by id from the database.

  ## Examples

      iex> certificate_id = "a3bea405-ca99-49fe-8739-71140192ad6f"

      iex> {:ok, %Devspot.Certificate{}} = Devspot.get_certificate_by_id(certificate_id)

  """
  defdelegate get_certificate_by_id(certificate_id),
    to: GetCertificate,
    as: :certificate_by_id

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

  @doc """
  Gets an experience by id from the database.

  ## Examples

      iex> experience_id = "b1533a10-e0c3-42e3-89cd-304fac1e63cf"

      iex> %Devspot.Experience{} = Devspot.get_experience_by_id(experience_id)

  """
  defdelegate get_experience_by_id(experience_id),
    to: GetExperience,
    as: :experience_by_id

  @doc """
  Deletes an experience from the database.

  ## Examples

    * creating an experience

          iex> experience_params = %{
            "user_id" => "6721ba81-00ce-46cd-b26c-973989b61c55",
            "company" => "Rocketseat",
            "end" => "30/12/2012",
            "role" => "Educator",
            "start" => "30/11/2011"
          }

          iex> {:ok, %Devspot.Experience{id: experience_id}} = Devspot.create_experience(experience_params)

    * deleting an experience

          iex> {:ok, %Devspot.Experience{}} = Devspot.delete_experience(experience_id)

    * getting the deleted experience

          iex> {:error, %Devspot.Error{}} = Devspot.Experiences.Get.experience_by_id(experience_id)

  """
  defdelegate delete_experience(experience_id),
    to: DeleteExperience,
    as: :call

  @doc """
  Inserts an article into the database.

  ## Examples

    iex> article_params = %{"user_id" => "6721ba81-00ce-46cd-b26c-973989b61c55", "url" => "https://dev.to/maiquitome/o-ciclo-de-vida-do-request-no-phoenix-53e7", "title" => "O Ciclo de Vida do Request no Phoenix"}

    iex> {:ok, %Devspot.Article{}} = Devspot.create_article(article_params)

  """
  defdelegate create_article(params),
    to: CreateArticle,
    as: :call

  @doc """
  Gets all articles by user in the database.

  ## Examples

      iex> user_id = "6721ba81-00ce-46cd-b26c-973989b61c55"

      iex> {:ok, schema_list} = Devspot.get_all_articles(user_id)

  """
  defdelegate get_all_articles(user_id),
    to: GetArticle,
    as: :all_by_user_id

  @doc """
  Gets an article by id from the database.

  ## Examples

      iex> article_id = "d8d256d3-9f97-46ce-ad4c-08e1c01f09ad"

      iex> {:ok, %Devspot.Article{}} = Devspot.get_article_by_id(article_id)

  """
  defdelegate get_article_by_id(article_id),
    to: GetArticle,
    as: :article_by_id

  @doc """
  Deletes an article from the database.

  ## Examples

    * creating an article

        iex> article_params = %{"user_id" => "6721ba81-00ce-46cd-b26c-973989b61c55", "url" => "https://dev.to/maiquitome/o-ciclo-de-vida-do-request-no-phoenix-53e7", "title" => "O Ciclo de Vida do Request no Phoenix"}

        iex> {:ok, %Devspot.Article{id: article_id}} = Devspot.create_article(article_params)

    * deleting an article

        iex> {:ok, %Devspot.Article{}} = Devspot.delete_article(article_id)

    * getting the deleted article

        iex> {:error, %Devspot.Error{}} = Devspot.Articles.Get.article_by_id(article_id)

  """
  defdelegate delete_article(article_id),
    to: DeleteArticle,
    as: :call
end
