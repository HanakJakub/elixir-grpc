defmodule GrpctestApp do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      supervisor(GRPC.Server.Supervisor, [{Grpctest.Endpoint, 50051}])
    ]

    opts = [strategy: :one_for_one, name: GrpctestApp]
    Supervisor.start_link(children, opts)
  end
end
