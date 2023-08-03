defmodule SilverForest.JobRegistry do
    alias SilverForest.JobQueue
    require Logger

    def register_job(id, payload) do
        Logger.info("Registering job with skill #{payload["skill"]}, for id #{id}")
        register_or_queue_job(id, payload)
    end

    def get_jobs(name) do
        case Registry.lookup(__MODULE__, name) do
            [] -> IO.inspect "nothing"
            [ {pid, nil} ] -> Agent.get(pid, & &1)
            _ -> Logger.warning "Registry element to fetch contained more than 1 entry (this shouldnt happen)"
        end
    end

    defp register_or_queue_job(id, payload) do
        case Registry.lookup(__MODULE__, id) do
            [] -> JobQueue.start_link(id, payload)
            [ {pid, nil} ] -> JobQueue.add_job_to_existing_queue(pid, payload)
        end
    end
end
