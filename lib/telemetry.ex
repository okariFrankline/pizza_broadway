defmodule Pizza.Telemetry do
  use Supervisor
  import Telemetry.Metrics

  def start_link(arg) do
    Supervisor.start_link(__MODULE__, arg, name: __MODULE__)
  end

  @impl true
  def init(_arg) do
    children = [
      # Telemetry poller will execute the given period measurements
      # every 10_000ms. Learn more here: https://hexdocs.pm/telemetry_metrics
      # {:telemetry_poller, measurements: periodic_measurements(), period: 10_000},
      # Add reporters as children of your supervision tree.
      {Telemetry.Metrics.ConsoleReporter, metrics: metrics()}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end

  def metrics do
    [


      ## broadway metrics
      summary("broadway.processor.stop.duration"
        # unit: {:native, :millisecond}
      ),
      summary("broadway.message.stop.duration",
        unit: {:native, :millisecond}
      ),
      summary("broadway.consumer.stop.duration",
        unit: {:native, :millisecond}
      ),
      summary("broadway.batcher.stop.duration",
        unit: {:native, :millisecond}
      )
    ]
  end

  # defp periodic_measurements do
  #   [
  #     # A module, function and arguments to be invoked periodically.
  #     # This function must call :telemetry.execute/3 and a metric must be added above.
  #     # {AbsintheWombatWeb, :count_users, []}
  #   ]
  # end
end
