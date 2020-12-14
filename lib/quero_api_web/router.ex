defmodule QueroApiWeb.Router do
  use QueroApiWeb, :router

  pipeline :api_as_user do
    plug :accepts, ["json"]
    plug QueroApiWeb.AuthAccessPipeline
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", QueroApiWeb do
    pipe_through :api
    get "/courses", CourseController, :index
    resources "/users", UserController, except: [:new]
    post "/users/sign_in", UserController, :sign_in
  end

  scope "/api", QueroApiWeb do
    pipe_through :api_as_user

    get "/offers", OfferController, :index
    resources "/users", UserController, except: [:edit]
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
      live_dashboard "/dashboard", metrics: QueroApiWeb.Telemetry
    end
  end
end
