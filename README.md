# Distributed calculator

This demo project is an adaptaion of the [distributed-calculator tutorial](https://github.com/dapr/quickstarts/blob/master/tutorials/distributed-calculator) from the [ beatiful collection of Dapr quickstarts and tutorials](https://github.com/dapr/quickstarts). It showcases Fleet as a polyglot IDE and such its features as smart mode, run configurations, debugging, integration with Git and Docker, remote development and remote collaboration.

The original distributed-calculator project shows method invocation and state persistent capabilities of [Dapr engine](https://docs.dapr.io/) through a distributed calculator where each operation is powered by a different service written in a different language/framework:

- **Addition** (port 6000, `/add`):
    - Go [mux](https://github.com/gorilla/mux) application
    - Java [Spark](https://sparkjava.com/) application
- **Multiplication** (port 5001, `/multiply`):
    - Python [flask](https://flask.palletsprojects.com/en/2.2.x/) application
    - Rust [actix_web](https://actix.rs/) application
- **Division** (port 4000, `/divide`):
    - Node [Express](https://expressjs.com/) application
    - Kotlin [Ktor](https://ktor.io/) application
- **Subtraction** (port 7001, `/subtract`):
    - [.NET Core](https://docs.microsoft.com/en-us/dotnet/core/) application

Every backend application listens the port that corresponds to the operation it powers and answers one kind of POST requests with the JSON-encoded body like the following:
    ```json
    {
        "operandOne":"52",
        "operandTwo":"34"
    }
    ```

The result is a single number. There should be one service per operation at the most running at any time.

The front-end application consists of a server and a client written in [React](https://reactjs.org/). 
Kudos to [ahfarmer](https://github.com/ahfarmer) for [React calculator](https://github.com/ahfarmer/calculator).

The following architecture diagram illustrates the components that make up this project:

![Architecture Diagram](./img/Architecture_Diagram.png)

## Prerequisites for running the project

1. Install [Dapr CLI](https://github.com/dapr/cli)
2. Install [.Net Core SDK 3.1](https://dotnet.microsoft.com/download)
3. Install [Go](https://golang.org/doc/install)
4. Install [Python3](https://www.python.org/downloads/) and [Pipenv](https://pypi.org/project/pipenv/)
5. Install [Npm](https://www.npmjs.com/get-npm)
6. Install [Node](https://nodejs.org/en/download/)
7. Install [Rust](https://rustup.rs/)

## Running the project locally

1. Once you have [Dapr CLI](https://github.com/dapr/cli) installed you should initialize it by running `dapr init`. This starts the Dapr services including Redis and Zipkin in Docker containers.

2. The content of the `./dev-env-warmup.sh` script can give you an idea of how to install project dependencies and build backend and frontend applications.

3. There are several Run Configurations (**Run/Run & Debug...**) to run frontend and backend applications along the dapr sidecar instances:

    - Frontend
    - Adder (Go)
    - Adder (Java)
    - Subtracter (C#)
    - Multiplier (Python)
    - Multiplier (Rust)
    - Divider (Kotlin)
    - Divider (Node JS)

4. Open a browser window and go to http://localhost:8080/. From here, you can enter the different operations.

    ![Calculator Screenshot](./img/calculator-screenshot.JPG)

5. Open your browser's console window (using F12 key) to see the logs produced as you use the calculator. Note that each time you click a button, you see logs that indicate state persistence and the different apps that are contacted to perform the operation.

6. **Optional:** Validate Services

To make sure all the backend applications are working, you can run the **Validate Services** run configuration which will test all the operations and report if something is missing. This configuration executes the `./validate-services` script. If everything works correctly you should get the following output:
    ```bash
    ADD             ✅
    SUBTRACT        ✅
    MULTIPLY        ✅
    DIVIDE          ✅
    ```

7. **Optional:** Check persistent state (powered by redis)

- To check persistent state, you can run the following `curl` request:
    ```bash
    curl -s http://localhost:8080/state
    ```
  Sample response:
    ```bash
    {"operation":null,"total":"42","next":null}
    ```

- Another option is to run `redis-cli` in the Redis docker container. Open the **Docker** tool in one of the side panels, find the `dapr_redis` container, focus on it, and open a terminal (button to the right of the container's name and port number). Sample session in the terminal:
  ```bash
  root@a20170d47d09:/data# redis-cli
  127.0.0.1:6379> keys *
  1) "frontendapp||calculatorState"
  127.0.0.1:6379> hgetall "frontendapp||calculatorState"
  1) "data"
  2) "{\"total\":\"2\",\"next\":\"3\",\"operation\":\"+\"}"
  3) "version"
  4) "3"
  127.0.0.1:6379> hget "frontendapp||calculatorState" "data"
  "{\"total\":\"2\",\"next\":\"3\",\"operation\":\"+\"}"
  127.0.0.1:6379>
  ```

8. Cleanup

- Cleanup microservices: **Stop Services** run configuration (executes `./stop-services.sh`).

- Uninstall node modules by navigating to the node directory and run:
  ```
  npm uninstall
  ```
- Uninstall Dapr and remove its Docker services:
  ```bash
  dapr uninstall --all
  ```