# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Devspot.Repo.insert!(%Devspot.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Devspot.{Repo, Skill}

Repo.delete_all(Skill)

skills = [
  %Skill{
    name: "React",
    image_url: "https://www.lucianopastine.tech/img/about-logos/reactjs.png"
  },
  %Skill{
    name: "Elixir",
    image_url:
      "https://www.promptworks.com/static/f4f0894037b32313eb3b6fa56806453a/47203/15cdc4d261d3e4aca9d8856d1bdd90be.webp"
  },
  %Skill{
    name: "Docker",
    image_url: "https://pbs.twimg.com/profile_images/1273307847103635465/lfVWBmiW_400x400.png"
  },
  %Skill{
    name: "REST",
    image_url:
      "https://15f76u3xxy662wdat72j3l53-wpengine.netdna-ssl.com/wp-content/themes/x-child-onix/images/for-connectors/rest.png"
  },
  %Skill{
    name: "Linux",
    image_url:
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSZ2LQuzOkmL0VsHAv5BZyGXpH_BElZjvbB0XLK4yWkl0KDjdMiHSFLZVq4No-eoO6dQ8k&usqp=CAU"
  },
  %Skill{
    name: "Javascript",
    image_url: "https://upload.wikimedia.org/wikipedia/commons/6/6a/JavaScript-logo.png"
  },
  %Skill{
    name: "Python",
    image_url:
      "https://static.cloud-boxloja.com/lojas/wyfyg/produtos/cf02b27f-ab1b-4a50-ad17-4aa4e0368a94.jpg"
  }
]

Enum.each(skills, fn skill -> Repo.insert!(skill) end)
