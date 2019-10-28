defmodule ServerTest do
    use ExUnit.Case
    doctest Grpctest.Server
  
    test "get_user_data should return all users purchases" do
        p = Grpctest.Server.get_user_data("./task/data/", "1.json")
        assert length(p) == 5
    end

    test "get_user_data should fail when file does not exist" do
        assert catch_error(Grpctest.Server.get_user_data("./task/data/", "0.json"))
    end
  end
  