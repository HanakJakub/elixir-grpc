defmodule Grpctest.Client do
    @compile if Mix.env == :test, do: :export_all

    @data_path "./task/data/"

    defmodule List do
        def flatten([]), do: []
        def flatten([h|t]), do: flatten(h) ++ flatten(t)
        def flatten(h), do: [h] 
    end

    def main(channel) do
        startTime = Time.utc_now()

        retrieve_replies(channel)
        |> process_replies()
        |> print_results(startTime)
    end

    defp print_results(data, startTime) do 
        IO.write("Median is: ")
        IO.inspect(median(data))
        IO.write("Average is: ")
        IO.inspect(mean(data))
        IO.write("Process took ")
        IO.write(Time.diff(Time.utc_now(), startTime , :microsecond) / 1000)
        IO.write("ms\n")
    end

    defp retrieve_replies(channel) do 
        walk_json_files()
            |> Enum.map(fn file ->
                request = Protobuf.Request.new(name: Path.basename(file), path: @data_path)
                {:ok, reply} = 
                    channel |> Protobuf.Processor.Stub.purchaser(request)

                IO.inspect(reply)    
            end)
    end

    defp process_replies(replies) do 
        Enum.map(replies, fn r ->
            Poison.decode!(r.result, as: [%Grpctest.Structs.Purchase{}])
        end)
        |> List.flatten()
        |> Enum.group_by(fn x -> x.type end)
        |> Enum.filter(fn {_, x} -> length(x) >= 5 end)
        |> Enum.map(fn {_, x} -> x end)
        |> List.flatten()
    end

    defp walk_json_files do
        Path.wildcard(@data_path <> "*.json")
    end

    defp median(list) do
        len = length(list)
        sorted = Enum.sort_by(list, fn x -> x.amount end)
        mid = div(len, 2)
        if rem(len,2) == 0, do: (Enum.at(sorted, mid-1).amount + Enum.at(sorted, mid).amount) / 2,
                        else: Enum.at(sorted, mid).amount
    end 

    defp mean(list) do
        len = length(list)
        total = Enum.reduce(list, 0,fn x, acc -> 
            x.amount + acc
        end) 

        total / len
    end 
  end
  