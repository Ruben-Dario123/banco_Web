defmodule BancoWebWeb.PageController do
  use BancoWebWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
