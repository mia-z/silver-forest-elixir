defmodule Routes.ForestryRoute do
    use Plug.Router

    plug :match

    plug SilverForest.Auth.Plug

    plug :dispatch

    get "/woodcut" do
        send_resp(conn, 200, "chop chop!")
    end

    match _ do
        send_resp(conn, 404, "Not Found")
    end
end
