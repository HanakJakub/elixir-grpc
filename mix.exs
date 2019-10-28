defmodule Grpctest.Mixfile do
  use Mix.Project

  def project do
    [app: :grpctest,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [mod: {GrpctestApp, []},
     applications: [:logger, :grpc]]
  end

  defp deps do
    [
      {:grpc, github: "elixir-grpc/grpc"},
      {:poison, "~> 3.1"},
      {:protobuf, github: "tony612/protobuf-elixir", override: true},
      {:dialyxir, "~> 0.5", only: [:dev, :test], runtime: false},
    ]
  end
end
