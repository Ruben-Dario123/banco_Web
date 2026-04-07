defmodule BancoWeb.Accounts do
  alias BancoWeb.Repo
  alias BancoWeb.Accounts.User
  alias BancoWeb.Accounts.UserToken

  def get_user_by_email(email) do
    Repo.get_by(User, email: email)
  end

  def get_user!(id), do: Repo.get!(User, id)

  def authenticate_user(email, password) do
    user = get_user_by_email(email)

    cond do
      user && verify_password(user.password, password) ->
        {:ok, user}

      user ->
        {:error, :unauthorized}

      true ->
        Pbkdf2.no_user_verify()
        {:error, :not_found}
    end
  end

  defp verify_password(stored_hash, password) do
    Pbkdf2.verify_pass(password, stored_hash)
  end

  def get_user_by_session_token(token) do
    UserToken.verify_session_token(token)
  end

  def create_user_token(user_id) do
    {token, user_token} = UserToken.build_session_token(user_id)
    Repo.insert!(user_token)
    token
  end

  def delete_user_session_token(token) do
    Repo.delete_all(UserToken.token_and_context_query(token, "session"))
    :ok
  end

  def delete_all_user_sessions(user_id) do
    Repo.delete_all(UserToken.user_and_context_query(user_id, "session"))
    :ok
  end

  def update_last_login(user) do
    user
    |> User.changeset(%{ultimo_login: DateTime.utc_now()})
    |> Repo.update()
  end
end
