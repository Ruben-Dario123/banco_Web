defmodule BancoWeb.Repo.Migrations.CreateUsuariosTokens do
  use Ecto.Migration

  def change do
    create table(:usuarios_tokens) do
      add :token, :binary, null: false
      add :context, :string, null: false
      add :sent_to, :string
      add :user_id, references(:usuarios, on_delete: :delete_all, type: :int), null: false

      timestamps(updated_at: false)
    end

    create index(:usuarios_tokens, [:user_id])
    create index(:usuarios_tokens, [:context])
  end
end
