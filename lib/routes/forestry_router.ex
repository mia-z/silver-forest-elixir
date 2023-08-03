defmodule Routes.ForestryRouter do
    import Plug.Conn
    import Logger

    use Plug.Router

    plug :match

    plug SilverForest.Auth.Plug

    plug :dispatch

    post "/woodcut" do
        case read_body(conn) do
            {:ok, body, conn} -> parse_body(conn, body)
            {:error, _term} -> send_resp(conn, 500, "Body read failure")
        end
    end

    match _ do
        send_resp(conn, 404, "Not Found")
    end

    defp parse_body(conn, body_string) do
        case Jason.decode(body_string) do
            {:ok, res} -> validate_body(conn, res)
            {:error, error} -> send_resp(conn, 400, Jason.encode!(%{ data: error.data, position: error.position, token: error.token }))
        end
    end

    defp validate_body(conn, body_json) do
        create_job(conn, body_json)
    end

    defp create_job(conn, json) do
        id = conn.assigns[:id]
        info "Creating job!"
        case SilverForest.JobRegistry.register_job(id, json) do
            {:ok, _res} -> send_resp(conn, 200, "chop chop!")
            {:error, reason} -> send_resp(conn, 500, reason)
        end
    end
end
