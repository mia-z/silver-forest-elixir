defmodule SilverForest.MixProject do
    use Mix.Project

    def project do
        [
            app: :silver_forest,
            version: "0.1.0",
            elixir: "~> 1.15",
            start_permanent: Mix.env() == :prod,
            deps: deps()
        ]
    end

    def application do
        [
            mod: {SilverForest, []},
            extra_applications: [:logger]
        ]
    end

    defp deps do
        [
            {:ecto_sql, "~> 3.3.0"},
            {:bandit, "~> 1.0-pre"},
            {:plug, "~> 1.14.2"},
            {:postgrex, "~> 0.15.13"},
            {:joken, "~> 2.5"},
            {:jason, "~> 1.3"},
            {:bcrypt_elixir, "~> 3.0.1"},
            {:enum_type, "~> 1.1.0"},
            {:ex_json_schema, "~> 0.10.1"}
        ]
    end
end
