# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     BancoWeb.Repo.insert!(%BancoWeb.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

import Ecto.Query
alias BancoWeb.Repo
alias BancoWeb.Accounts.User

# Update passwords to be compatible with pbkdf2
# The default password is "password"
hashed_password = Pbkdf2.hash_pwd_salt("password")

users = Repo.all(User)

for user <- users do
  user
  |> User.changeset(%{password: hashed_password})
  |> Repo.update!()
end

IO.puts("Updated #{length(users)} user passwords to use pbkdf2")
