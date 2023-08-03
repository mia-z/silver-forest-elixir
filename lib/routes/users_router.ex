defmodule Routes.UsersRouter do
    use Plug.Router

    plug :match

    plug SilverForest.Auth.Plug

    plug :dispatch

    get "/me" do
        send_resp(conn, 200, "its me!")
    end

    get "/me/jobs" do
        id = conn.assigns[:id]
        |> to_string
        jobs = SilverForest.JobRegistry.get_jobs("job_" <> id)
        send_resp(conn, 200, Jason.encode!(jobs))
    end

    match _ do
        send_resp(conn, 404, "Not Found")
    end
end
