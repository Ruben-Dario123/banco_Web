defmodule BancoWeb.Accounts.User do
  use Ecto.Schema

  # Configuramos para que use tus nombres de columna en español
  @timestamps_opts [inserted_at: :creado_en, updated_at: false]

  schema "usuarios" do
    field :email, :string
    field :password, :string
    field :rol_id, :integer
    field :cliente_id, :integer
    field :activo, :boolean, default: true
    field :ultimo_login, :naive_datetime

    timestamps()

    has_one :user_token, BancoWeb.Accounts.UserToken
  end

  def changeset(user, attrs) do
    user
    |> Ecto.Changeset.cast(attrs, [:email, :password, :rol_id, :cliente_id, :activo, :ultimo_login])
  end
end
