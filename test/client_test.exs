defmodule ClientTest do
    use ExUnit.Case
    doctest Grpctest.Client
  
    test "walk_json_files should return list of json file names" do
        Grpctest.Client.walk_json_files()
        |> Enum.map(fn f -> 
            assert Path.extname(f) == ".json"
        end)
    end

    test "median should return value of median" do
        list = [
            %Grpctest.Structs.Purchase{amount: 100, type: "test"},
            %Grpctest.Structs.Purchase{amount: 100, type: "test"},
            %Grpctest.Structs.Purchase{amount: 100, type: "test"},
            %Grpctest.Structs.Purchase{amount: 5, type: "test"},
            %Grpctest.Structs.Purchase{amount: 5, type: "test"}
        ]
        assert Grpctest.Client.median(list) == 100
    end

    test "mean should return average value of purchases" do
        list = [
            %Grpctest.Structs.Purchase{amount: 100, type: "test"},
            %Grpctest.Structs.Purchase{amount: 100, type: "test"},
            %Grpctest.Structs.Purchase{amount: 100, type: "test"},
            %Grpctest.Structs.Purchase{amount: 5, type: "test"},
            %Grpctest.Structs.Purchase{amount: 5, type: "test"}
        ]
        assert Grpctest.Client.mean(list) == 62
    end
  end
  