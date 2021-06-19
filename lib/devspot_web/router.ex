defmodule DevspotWeb.Router do
  use DevspotWeb, :router

  alias DevspotWeb.Auth.Pipeline, as: AuthPipeline

  pipeline :api do
    plug(CORSPlug,
      origin: [
        "https://frontend-git-develop-fullstack-alchemists.vercel.app/",
        "http://localhost:3000"
      ]
    )

    plug(:accepts, ["json"])
  end

  pipeline :auth do
    plug(AuthPipeline)
  end

  scope "/api", DevspotWeb do
    pipe_through([:api, :auth])

    post "/certificates", CertificatesController, :create
    post "/experiences", ExperiencesController, :create
    post "/articles", ArticlesController, :create
  end

  scope "/api", DevspotWeb do
    pipe_through(:api)

    post "/users", UsersController, :create
    post "/users/sign_in", UsersController, :sign_in
    get "/users/:id", UsersController, :show
    get "/experiences/:user_id", ExperiencesController, :show
    delete "/experiences/:id", ExperiencesController, :delete
    get "/certificates/:user_id", CertificatesController, :show
    delete "/certificates/:id", CertificatesController, :delete
    get "/articles/:user_id", ArticlesController, :show
    delete "/articles/:id", ArticlesController, :delete
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through([:fetch_session, :protect_from_forgery])
      live_dashboard("/dashboard", metrics: DevspotWeb.Telemetry)
    end
  end
end
