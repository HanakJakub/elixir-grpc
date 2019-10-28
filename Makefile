all: build 

dep:
	@echo "Install dependencies"
	mix do deps.get

protoc:
	@echo "Generating Protoc files"
	protoc -I priv/protos --elixir_out=plugins=grpc:./lib/ priv/protos/*.proto

build: dep protoc
	@echo "Compile application"
	mix do compile

.PHONY: protoc dep
