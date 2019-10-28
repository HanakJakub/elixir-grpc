defmodule Protobuf.Request do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          path: String.t(),
          name: String.t()
        }
  defstruct [:path, :name]

  field :path, 1, type: :string
  field :name, 2, type: :string
end

defmodule Protobuf.Response do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          result: String.t()
        }
  defstruct [:result]

  field :result, 1, type: :string
end

defmodule Protobuf.Processor.Service do
  @moduledoc false
  use GRPC.Service, name: "protobuf.Processor"

  rpc :Purchaser, Protobuf.Request, Protobuf.Response
end

defmodule Protobuf.Processor.Stub do
  @moduledoc false
  use GRPC.Stub, service: Protobuf.Processor.Service
end
