defmodule DevspotWeb.Router do
  use DevspotWeb, :router

  alias DevspotWeb.Auth.Pipeline, as: AuthPipeline

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug AuthPipeline
  end

  scope "/api", DevspotWeb do
    pipe_through [:api, :auth]

    post "/certificates", CertificatesController, :create
  end

  scope "/api", DevspotWeb do
    pipe_through :api

    post "/users", UsersController, :create
    get "/users/:id", UsersController, :show
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
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: DevspotWeb.Telemetry
    end
  end
end
