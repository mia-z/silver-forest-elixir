defmodule SilverForest.Repo do
    use Ecto.Repo,
        otp_app: :silver_forest,
        adapter: Ecto.Adapters.Postgres
end
