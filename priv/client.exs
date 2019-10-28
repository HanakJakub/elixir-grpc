opts = [interceptors: [GRPC.Logger.Client]]

{:ok, channel} = GRPC.Stub.connect("localhost:50051", opts)

Grpctest.Client.main(channel)