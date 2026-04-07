defmodule BancoWebWeb.DashboardController do
  use BancoWebWeb, :controller

  def index(conn, _params) do
    user = conn.assigns.current_user
    render(conn, :index, user: user)
  end
end
