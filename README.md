# Distributed calculator

This demo project is an adaptaion of the [distributed-calculator tutorial](https://github.com/dapr/quickstarts/blob/master/tutorials/distributed-calculator) from the [ beatiful collection of Dapr quickstarts and tutorials](https://github.com/dapr/quickstarts). It showcases Fleet as a polyglot IDE and such its features as smart mode, run configurations, debugging, integration with Git and Docker, remote development and remote collaboration.

This project shows method invocation and state persistent capabilities of [Dapr engine](https://docs.dapr.io/) through a distributed calculator where each operation is powered by a different service written in a different language/framework:

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

Every backend application listens the port that corresponds to the operation it powers and answers exactly one POST request with the following JSON in its body:

```json
{
    "operandOne":"52",
    "operandTwo":"34"
}
```

It returns one number as a result. There should be one service per operation at the most running at any time.

The front-end application consists of a server and a client written in [React](https://reactjs.org/). 
Kudos to [ahfarmer](https://github.com/ahfarmer) for [React calculator](https://github.com/ahfarmer/calculator).

The following architecture diagram illustrates the components that make up this quickstart: 

![Architecture Diagram](./img/Architecture_Diagram.png)

## Prerequisites for running the project

### - Run locally
1. Install [.Net Core SDK 3.1](https://dotnet.microsoft.com/download)
2. Install [Dapr CLI](https://github.com/dapr/cli)
3. Install [Go](https://golang.org/doc/install)
4. Install [Python3](https://www.python.org/downloads/)
5. Install [Npm](https://www.npmjs.com/get-npm)
6. Install [Node](https://nodejs.org/en/download/)


## Running the quickstart locally

These instructions start the four calculator operator apps (add, subtract, multiply and divide) along with the dapr sidecar locally and then run the front end app which persists the state in a local redis state store.


1. Add App - Open a terminal window and navigate to the go directory and follow the steps below:

- Install the gorilla/mux package: Run:
   ```bash
   go get -u github.com/gorilla/mux
   ```

- Build the app. Run:
   ```bash
   go build .
   ```

- Run dapr using the command:
   ```bash
   dapr run --app-id addapp --app-port 6000 --dapr-http-port 3503 go run app.go
   ```

2. Subtract App - Open a terminal window and navigate to the csharp directory and follow the steps below:

- Set environment variable to use non-default app port 7001
   ```bash
   #Linux/Mac OS:
   export ASPNETCORE_URLS="http://localhost:7001"
   ```

   ```bash
   #Windows:
   set ASPNETCORE_URLS=http://localhost:7001
   ```

- Build the app. Run:
   ```bash
   dotnet build
   ```


- Navigate to ./bin/Debug/netcoreapp3.1 and start Dapr using command:
   ```bash
   dapr run --app-id subtractapp --app-port 7001 --dapr-http-port 3504 dotnet Subtract.dll
   ```


3. Divide App - Open a terminal window and navigate to the node directory and follow the steps below:

- Install dependencies by running the command:
   ```bash
   npm install
   ```

- Start Dapr using the command below
   ```bash
   dapr run --app-id divideapp --app-port 4000 --dapr-http-port 3502 node app.js
   ```

4. Multiply App - Open a terminal window and navigate to the python directory and follow the steps below:

- Install required packages
   ```bash
   pip3 install wheel python-dotenv flask_cors flask
   ```

- Set environment variable to use non-default app port 5000
   ```bash
   #Linux/Mac OS:
   export FLASK_RUN_PORT=5001
   
   #Windows:
   set FLASK_RUN_PORT=5001
   ```

- Start dapr using the command:
   ```bash
   dapr run --app-id multiplyapp --app-port 5001 --dapr-http-port 3501 flask run
   ```

5. Frontend Calculator app - Open a terminal window and navigate to the react-calculator directory and follow the steps below:

- Install the required modules
   ```bash
   npm install
   npm run buildclient
   ```

- Start Dapr using command below:
   ```bash
   dapr run --app-id frontendapp --app-port 8080 --dapr-http-port 3507 node server.js
   ```

6. Open a browser window and go to http://localhost:8080/. From here, you can enter the different operations.

    ![Calculator Screenshot](./img/calculator-screenshot.JPG)

7. Open your browser's console window (using F12 key) to see the logs produced as you use the calculator. Note that each time you click a button, you see logs that indicate state persistence and the different apps that are contacted to perform the operation. 

8. **Optional:** Curl Validate

- To make sure all the apps are working, you can run the following curl commands which will test all the operations:
   ```bash
   curl -s http://localhost:8080/calculate/add -H Content-Type:application/json --data @operands.json
   ```

   ```bash
   curl -s http://localhost:8080/calculate/subtract -H Content-Type:application/json --data @operands.json
   ```

   ```bash
   curl -s http://localhost:8080/calculate/divide -H Content-Type:application/json --data @operands.json
   ```

   ```bash
   curl -s http://localhost:8080/calculate/multiply -H Content-Type:application/json --data @operands.json
   ```

   ```bash
   curl -s http://localhost:8080/persist -H Content-Type:application/json --data @persist.json
   ```

   ```bash
   curl -s http://localhost:8080/state 
   ```

- You should get the following output:
   ```bash
   86
   18
   1.5294117647058822
   1768
   
   {"operation":null,"total":"54","next":null}
   ```

9. Cleanup

- Cleanup microservices

   ```bash
   dapr stop --app-id addapp
   ```

   ```bash
   dapr stop --app-id subtractapp
   ```
   
   ```bash
   dapr stop --app-id divideapp
   ```
   
   ```bash
   dapr stop --app-id multiplyapp
   ```

   ```bash
   dapr stop --app-id frontendapp
   ```


- Uninstall node modules by navigating to the node directory and run:
  ```
  npm uninstall
  ```