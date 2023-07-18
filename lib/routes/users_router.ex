defmodule Routes.UsersRouter do
    use Plug.Router

    plug :match

    plug SilverForest.Auth.Plug

    plug :dispatch

    get "/me" do
        send_resp(conn, 200, "its me!")
    end

    match _ do
        send_resp(conn, 404, "Not Found")
    end
end
