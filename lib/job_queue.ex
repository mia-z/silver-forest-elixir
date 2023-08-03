defmodule SilverForest.JobQueue do
    use Agent

    require Logger

    def start_link(id, payload) do
        Logger.info( "Starting job_queue process with id: #{id}")
        {:ok, pid} = Agent.start_link(fn -> %{ id: id, jobs: [ payload ]} end, name: {:via, Registry, { SilverForest.JobRegistry, id }})
        run pid
        {:ok, "created"}
    end

    def add_job_to_existing_queue(pid, payload) do
        Logger.info("Adding new job to existing queue: #{inspect pid}")
        %{ id: _id, jobs: jobs } = Agent.get(pid, & &1)
        if length(jobs) < 5 do
            Agent.update(pid, fn current -> %{ current | jobs: current.jobs ++ [payload] } end)
            {:ok, "added"}
        else
            {:error, "max jobs (5)"}
        end
    end

    defp run(pid) do
        Task.start fn ->
            case Agent.get(pid, & &1) do
                %{ id: id, jobs: [] } ->
                    Logger.info "no jobs left in #{id} with pid#{inspect pid}"
                    Agent.stop(pid)
                %{ id: id, jobs: [head | _tail]} ->
                    # do something with head - this will be payload data for a skill job
                    Process.sleep(head["delay"]) # pretend work
                    Logger.info "Done a job on #{id} with pid#{inspect pid}"
                    %{ id: _id, jobs: [_head | tail]} = Agent.get(pid, & &1)
                    Agent.update(pid, fn current -> %{ current | jobs: tail } end)
                    run pid
            end
        end
    end
end
