defmodule BancoWebWeb.Router do
  use BancoWebWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {BancoWebWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug BancoWebWeb.UserAuth
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BancoWebWeb do
    pipe_through :browser

    get "/", PageController, :home
    get "/login", SessionController, :new
    post "/sessions", SessionController, :create
    delete "/sessions", SessionController, :delete
    get "/dashboard", DashboardController, :index
  end

  if Application.compile_env(:banco_web, :dev_routes) do
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: BancoWebWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
