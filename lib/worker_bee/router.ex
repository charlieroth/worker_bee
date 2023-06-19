defmodule WorkerBee.Router do
  use Plug.Router
  alias WebSockEx.DriverServer
  alias Phoenix.PubSub

  plug(Plug.Logger)
  plug(Plug.Parsers, parsers: [:json], pass: ["application/json"], json_decoder: Jason)
  plug(:match)
  plug(:dispatch)

  get "/websocket" do
    conn
    |> WebSockAdapter.upgrade(DriverServer, %{}, timeout: 60_000)
    |> halt()
  end

  match _ do
    send_resp(conn, 404, "Not Found")
  end
end
