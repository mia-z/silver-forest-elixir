defmodule SilverForest do
    use Application

    def start(_type, _args) do
        children = [
            SilverForest.Repo,
            { Registry, name: SilverForest.JobRegistry, keys: :unique },
            { Bandit, plug: SilverForest.RootRouter },
        ]
        Supervisor.start_link(children, strategy: :one_for_one)
    end
end
