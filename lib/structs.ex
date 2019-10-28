defmodule Grpctest.Structs do
    defmodule User do
        @derive [Poison.Encoder]
        defstruct [:purchases]
    end

    defmodule Purchase do
        defstruct type: "", amount: 0 
    end
end