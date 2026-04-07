defmodule BancoWebWeb.UserAuth do
  import Plug.Conn
  import Phoenix.Controller
  alias BancoWeb.Accounts

  def init(opts), do: opts

  def call(conn, _opts) do
    user_token = get_session(conn, :user_token)
    user = user_token && Accounts.get_user_by_session_token(user_token)
    assign(conn, :current_user, user)
  end

  def on_mount(:default, _params, _session, socket) do
    {:cont, socket}
  end

  def on_mount(:ensure_authenticated, _params, _session, %{assigns: %{current_user: user}} = socket) when user != nil do
    {:cont, socket}
  end

  def on_mount(:ensure_authenticated, _params, _session, socket) do
    socket =
      socket
      |> put_flash(:error, "Debes iniciar sesión para acceder a esta página.")
      |> redirect(to: "/login")

    {:halt, socket}
  end

  def require_authenticated_user(conn, _opts) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_flash(:error, "Debes iniciar sesión para acceder a esta página.")
      |> redirect(to: "/login")
      |> halt()
    end
  end
end
