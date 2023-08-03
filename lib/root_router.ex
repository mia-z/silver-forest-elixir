defmodule SilverForest.RootRouter do
    use Plug.Router

    plug :match
    plug :dispatch

    forward "/forestry", to: Routes.ForestryRouter
    forward "/users", to: Routes.UsersRouter

    post "/create" do
        case Plug.Conn.read_body(conn) do
            {:ok, body, conn} ->
                decode_body(conn, body)
                |> validate_body
                |> create_user
                |> handle_token_response
        end
    end

    match _ do
        send_resp(conn, 404, "Not Found")
    end

    defp decode_body(conn, body) do
        case Jason.decode(body) do
            {:ok, decoded} -> {conn, decoded}
            {:error, _} -> send_resp(conn, 400, "Malformed JSON")
        end
    end

    defp validate_body({conn, body}) do
        changeset = SilverForest.Schemas.User.changeset(%SilverForest.Schemas.User{}, body)
        case changeset do
            %{:valid? => true} -> {conn, changeset}
            %{:valid? => false} -> send_resp(conn, 400, "Schema Invalid")
        end
    end

    defp create_user({conn, changeset}) do
        case SilverForest.Repo.insert(changeset) do
            {:ok, user} -> {conn, %{ "id" => user.id }}
            {:error, error} -> send_resp(conn, 400, Jason.encode!(error))
        end
    end

    defp handle_token_response({conn, claims}) do
        case SilverForest.Auth.AuthToken.generate_and_sign(claims) do
            {:ok, token, _} -> send_resp(conn, 201, token)
            {:error, reason} -> send_resp(conn, 400, to_string(reason))
        end
    end
end
