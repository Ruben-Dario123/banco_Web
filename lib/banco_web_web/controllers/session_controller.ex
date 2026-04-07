defmodule BancoWebWeb.SessionController do
  use BancoWebWeb, :controller

  alias BancoWeb.Accounts

  def new(conn, _params) do
    render(conn, :new)
  end

  def create(conn, %{"session" => session_params}) do
    %{"email" => email, "password" => password} = session_params

    case Accounts.authenticate_user(email, password) do
      {:ok, user} ->
        Accounts.update_last_login(user)
        token = Accounts.create_user_token(user.id)

        conn
        |> put_session(:user_token, token)
        |> put_flash(:info, "Bienvenido, #{user.email}")
        |> redirect(to: "/dashboard")

      {:error, _reason} ->
        conn
        |> put_flash(:error, "Email o contraseña inválidos")
        |> render(:new)
    end
  end

  def delete(conn, _params) do
    user = conn.assigns.current_user

    if user do
      Accounts.delete_all_user_sessions(user.id)
    end

    token = get_session(conn, :user_token)

    if token do
      Accounts.delete_user_session_token(token)
    end

    conn
    |> clear_session()
    |> put_flash(:info, "Sesión cerrada correctamente")
    |> redirect(to: "/login")
  end
end
