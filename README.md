# Elixir gRPC solution

## Build and run without docker
Make sure you have install protoc and protoc elir generator and run `make` command inside root directory. It will get dependencies and compile application. First start server to start listen for incoming data `mix grpc.server` and then start client to send data `mix run priv/client.exs`. You will see result directly in terminal.

## Build and run with docker

### Build docker image 
Make sure your pwd is root folder of repository and run build
```shell
docker build -t elixir-app .
```

### Run docker image and start server
Start docker image.
```shell
docker run -it -p 50051:50051 elixir-app
```

### Start client
Show list of containers where you should see elixir-app running.
```shell
docker ps
```

Copy elixir-app container id and replace [container-id]
```shell
docker exec -it [container-id] bash
```

This command will exec bash in the container. To start client and process the data start
```shell
mix run priv/client.exs
```

## Testing
To run tests run `mix test` in root directory.