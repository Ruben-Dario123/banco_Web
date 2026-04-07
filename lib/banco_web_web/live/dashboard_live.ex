defmodule BancoWebWeb.DashboardLive do
  use BancoWebWeb, :live_view

  def mount(_params, session, socket) do
    user_token = session["user_token"]
    user = user_token && BancoWeb.Accounts.get_user_by_session_token(user_token)

    if user do
      {:ok, assign(socket, :user, user)}
    else
      {:halt, redirect(socket, to: "/login")}
    end
  end
end
