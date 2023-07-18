import Config

config :silver_forest, ecto_repos: [SilverForest.Repo]

config :silver_forest, SilverForest.Repo,
    database: "silver_forest_dev",
    username: "postgres",
    password: "123456",
    hostname: "localhost"

config :joken, default_signer: "rkhFkaWleSeT6G7Fqg962jtjhCSjGA1T"

config :silver_forest, SilverForest.Application,
    jwt_secret: "rkhFkaWleSeT6G7Fqg962jtjhCSjGA1T",
    alg: "HS256"
