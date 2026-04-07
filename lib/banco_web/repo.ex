defmodule BancoWeb.Repo do
  use Ecto.Repo,
    otp_app: :banco_web,
    adapter: Ecto.Adapters.MyXQL
end
