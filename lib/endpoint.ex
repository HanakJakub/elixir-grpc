defmodule Grpctest.Endpoint do
  use GRPC.Endpoint

  intercept GRPC.Logger.Server
  run Grpctest.Server
end
