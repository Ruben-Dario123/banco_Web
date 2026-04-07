defmodule BancoWeb.Accounts.UserToken do
  use Ecto.Schema
  import Ecto.Query

  schema "usuarios_tokens" do
    field :token, :binary
    field :context, :string
    field :sent_to, :string
    belongs_to :user, BancoWeb.Accounts.User

    timestamps(updated_at: false)
  end

  def user_and_context_query(user_id, context) do
    from(t in __MODULE__, where: t.user_id == ^user_id and t.context == ^context)
  end

  def token_and_context_query(token, context) do
    from(t in __MODULE__, where: t.token == ^token and t.context == ^context)
  end

  def build_session_token(user_id) do
    token = :crypto.strong_rand_bytes(32)
    {token, %__MODULE__{token: token, context: "session", user_id: user_id}}
  end

  def verify_session_token(token) do
    query =
      from(t in __MODULE__,
        where: t.token == ^token and t.context == "session",
        preload: :user
      )

    case BancoWeb.Repo.one(query) do
      nil -> nil
      token_record -> token_record.user
    end
  end
end
