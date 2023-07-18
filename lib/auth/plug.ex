defmodule SilverForest.Auth.Plug do
    import Plug.Conn

    def init(options), do: options

    @spec call(Plug.Conn.t(), any) :: Plug.Conn.t()
    def call(conn, _) do
        case get_req_header(conn, "authorization") do
            ["Bearer " <> token] ->
                verify_token(conn, token)
            _ ->
                send_resp(conn, 401, "Unauthorized")
                |> halt
        end
    end

    defp verify_token(conn, token) do
        case SilverForest.Auth.AuthToken.verify_and_validate(token) do
            {:ok, claims } ->
                conn
                |> Plug.Conn.assign(:id, Map.fetch!(claims, "id"))
            {:error, _} ->
                send_resp(conn, 401, "Unauthorized/Token sign error")
                |> halt
        end
    end
end

# (auth, ~r/^(Bearer )(?:[\w-]*\.){2}[\w-]*$/)
