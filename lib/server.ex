defmodule Grpctest.Server do
  @compile if Mix.env == :test, do: :export_all

  use GRPC.Server, service: Protobuf.Processor.Service

  @spec purchaser(Protobuf.Request.t(), GRPC.Server.Stream.t()) ::
          Protobuf.Response.t()

  def purchaser(request, _stream) do
      toResult =
        get_user_data(request.path, request.name)
        |> Enum.filter(fn p ->
            p.amount >= 150 and p.amount <= 10000
          end)
        |> Enum.uniq_by(fn x -> x.type end)
        |> Poison.encode!()

      Protobuf.Response.new(result: toResult)
  end

  defp get_user_data(path, filename) do
    {:ok, oFile} = File.read(path <> filename)
    Poison.decode!(oFile, as: %Grpctest.Structs.User{})
    |> process()
  end

  defp process(user) do 
      user.purchases
      |> Enum.map(fn p ->
          %Grpctest.Structs.Purchase{
              type: p["type"],
              amount: p["amount"]
          }
      end)
  end
end
