defmodule Devspot.Factory do
  use ExMachina.Ecto, repo: Devspot.Repo

  alias Devspot.{Article, Certificate, Experience, User}

  def user_params_factory do
    %{
      "email" => "maiqui@email.com",
      "password" => "123456",
      "first_name" => "Maiqui",
      "last_name" => "Tomé",
      "contact" => "54 9 9191-9292",
      "location" => "Flores da Cunha/RS",
      "status" => "Open",
      "id" => "b721fcad-e6e8-4e8f-910b-6911f2158b4a"
    }
  end

  def user_factory do
    %User{
      email: "maiqui@email.com",
      password: "123456",
      first_name: "Maiqui",
      last_name: "Tomé",
      contact: "54 9 9191-9292",
      location: "Flores da Cunha/RS",
      status: "Open",
      id: "b721fcad-e6e8-4e8f-910b-6911f2158b4a"
    }
  end

  def certificate_params_factory do
    %{
      "user_id" => "b721fcad-e6e8-4e8f-910b-6911f2158b4a",
      "url" => "https://balta.io/certificados/1fd6a983-6805-4bb6-8cbd-274e5364d9db",
      "title" => "Começando com Angular com carga horária de 2 horas"
    }
  end

  def certificate_factory do
    %Certificate{
      user_id: "b721fcad-e6e8-4e8f-910b-6911f2158b4a",
      url: "https://balta.io/certificados/1fd6a983-6805-4bb6-8cbd-274e5364d9db",
      title: "Começando com Angular com carga horária de 2 horas"
    }
  end

  def experience_params_factory do
    %{
      "user_id" => "b721fcad-e6e8-4e8f-910b-6911f2158b4a",
      "company" => "Stone",
      "role" => "Elixir Backend Developer",
      "start" => "30/11/2011",
      "end" => "30/12/2012"
    }
  end

  def experience_factory do
    %Experience{
      user_id: "b721fcad-e6e8-4e8f-910b-6911f2158b4a",
      company: "Stone",
      role: "Elixir Backend Developer",
      start: ~D[2011-11-30],
      end: ~D[2012-12-30]
    }
  end

  def article_params_factory do
    %{
      "user_id" => "b721fcad-e6e8-4e8f-910b-6911f2158b4a",
      "url" => "https://dev.to/maiquitome/o-ciclo-de-vida-do-request-no-phoenix-53e7",
      "title" => "O Ciclo de Vida do Request no Phoenix"
    }
  end

  def article_factory do
    %Article{
      user_id: "b721fcad-e6e8-4e8f-910b-6911f2158b4a",
      url: "https://dev.to/maiquitome/o-ciclo-de-vida-do-request-no-phoenix-53e7",
      title: "O Ciclo de Vida do Request no Phoenix"
    }
  end
end
