defmodule Devspot.Factory do
  use ExMachina.Ecto, repo: Devspot.Repo

  alias Devspot.User

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

  def skill_params_factory do
    %{
      "name" => "React",
      "image_url" => "https://www.lucianopastine.tech/img/about-logos/reactjs.png"
    }
  end
end
