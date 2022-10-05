# Distributed calculator

This quickstart shows method invocation and state persistent capabilities of Dapr through a distributed calculator where each operation is powered by a different service written in a different language/framework:

- **Addition**: Go [mux](https://github.com/gorilla/mux) application
- **Multiplication**: Python [flask](https://flask.palletsprojects.com/en/2.2.x/) application
- **Division**: Node [Express](https://expressjs.com/) application
- **Subtraction**: [.NET Core](https://docs.microsoft.com/en-us/dotnet/core/) application

The front-end application consists of a server and a client written in [React](https://reactjs.org/). 
Kudos to [ahfarmer](https://github.com/ahfarmer) whose [React calculator](https://github.com/ahfarmer/calculator) 

The following architecture diagram illustrates the components that make up this quickstart: 

![Architecture Diagram](./img/Architecture_Diagram.png)

## Prerequisites for running the quickstart
Clone the quickstarts repository
   ```bash
   git clone [-b <dapr_version_tag>] https://github.com/dapr/quickstarts.git
   ```
> **Note**: See https://github.com/dapr/quickstarts#supported-dapr-runtime-version for supported tags. Use `git clone https://github.com/dapr/quickstarts.git` when using the edge version of dapr runtime.

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

<!-- STEP
name: "Install the gorilla/mux"
working_dir: "./go"
-->

- Install the gorilla/mux package: Run:
   ```bash
   go get -u github.com/gorilla/mux
   ```

<!-- END_STEP -->

<!-- STEP
name: "Build go app"
working_dir: "./go"
-->

- Build the app. Run:
   ```bash
   go build .
   ```

<!-- END_STEP -->

<!-- STEP
expected_stdout_lines:
- "You're up and running! Both Dapr and your app logs will appear here."
- "== APP == Adding 52.000000 to 34.000000"
- "Exited Dapr successfully"
- "Exited App successfully"
expected_stderr_lines:
output_match_mode: substring
name: "Run go app"
working_dir: "./go"
background: true
sleep: 2
-->

- Run dapr using the command:
   ```bash
   dapr run --app-id addapp --app-port 6000 --dapr-http-port 3503 go run app.go
   ```

<!-- END_STEP -->

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

<!-- STEP
name: "Build dotnet app"
working_dir: "./csharp"
-->

- Build the app. Run:
   ```bash
   dotnet build
   ```

<!-- END_STEP -->

<!-- STEP
expected_stdout_lines:
  - "You're up and running! Both Dapr and your app logs will appear here."
  - "== APP == Subtracting 34 from 52"
  - "Exited Dapr successfully"
  - "Exited App successfully"
expected_stderr_lines:
name: "Run dotnet app"
output_match_mode: substring
working_dir: "./csharp/bin/Debug/netcoreapp3.1"
background: true
env: 
  ASPNETCORE_URLS: 'http://localhost:7001'
sleep: 2
-->

- Navigate to ./bin/Debug/netcoreapp3.1 and start Dapr using command:
   ```bash
   dapr run --app-id subtractapp --app-port 7001 --dapr-http-port 3504 dotnet Subtract.dll
   ```


<!-- END_STEP -->

3. Divide App - Open a terminal window and navigate to the node directory and follow the steps below:

<!-- STEP
name: "Build node app"
working_dir: "./node"
-->

- Install dependencies by running the command:
   ```bash
   npm install
   ```

<!-- END_STEP -->

<!-- STEP
expected_stdout_lines:
  - "You're up and running! Both Dapr and your app logs will appear here."
  - "== APP == Dividing 52 by 34"
  - "Exited Dapr successfully"
  - "Exited App successfully"
expected_stderr_lines:
output_match_mode: substring
name: "Run node app"
working_dir: "./node"
background: true
sleep: 2
-->

- Start Dapr using the command below
   ```bash
   dapr run --app-id divideapp --app-port 4000 --dapr-http-port 3502 node app.js
   ```

<!-- END_STEP -->

4. Multiply App - Open a terminal window and navigate to the python directory and follow the steps below:

<!-- STEP
name: "Build ptyhon app"
working_dir: "./python"
-->

- Install required packages
   ```bash
   pip3 install wheel python-dotenv flask_cors flask
   ```

<!-- END_STEP -->

- Set environment variable to use non-default app port 5000
   ```bash
   #Linux/Mac OS:
   export FLASK_RUN_PORT=5001
   
   #Windows:
   set FLASK_RUN_PORT=5001
   ```

<!-- STEP
expected_stdout_lines:
  - "You're up and running! Both Dapr and your app logs will appear here."
  - "== APP == Calculating 52.0 * 34.0"
  - "Exited Dapr successfully"
  - "Exited App successfully"
expected_stderr_lines:
name: "Run python app"
working_dir: "./python"
output_match_mode: substring
background: true
sleep: 2
env:
  FLASK_RUN_PORT: "5001"
-->

- Start dapr using the command:
   ```bash
   dapr run --app-id multiplyapp --app-port 5001 --dapr-http-port 3501 flask run
   ```

<!-- END_STEP -->

5. Frontend Calculator app - Open a terminal window and navigate to the react-calculator directory and follow the steps below:


<!-- STEP
name: "Build frontend app"
working_dir: "./react-calculator"
-->

- Install the required modules
   ```bash
   npm install
   npm run buildclient
   ```

<!-- END_STEP -->


<!-- STEP
expected_stdout_lines:
  - "You're up and running! Both Dapr and your app logs will appear here."
  - "Exited Dapr successfully"
  - "Exited App successfully"
expected_stderr_lines:
output_match_mode: substring
name: "Run frontent app"
working_dir: "./react-calculator"
background: true
sleep: 15
-->

- Start Dapr using command below:
   ```bash
   dapr run --app-id frontendapp --app-port 8080 --dapr-http-port 3507 node server.js
   ```

<!-- END_STEP -->


6. Open a browser window and go to http://localhost:8080/. From here, you can enter the different operations.

    ![Calculator Screenshot](./img/calculator-screenshot.JPG)

7. Open your browser's console window (using F12 key) to see the logs produced as you use the calculator. Note that each time you click a button, you see logs that indicate state persistence and the different apps that are contacted to perform the operation. 

<!-- STEP
name: Pause for manual validation
manual_pause_message: "Calculator APP running on http://localhost:8080. Please open in your browser and test manually."
-->

<!-- We will pause here and print the above message when mm.py is run with '-m'. Otherwise, this step does nothing -->

<!-- END_STEP -->

8. **Optional:** Curl Validate

<!-- STEP
expected_stdout_lines:
  - "86"
  - "18"
  - "1.5294117647058822"
  - "1768"
  - '"total":"54"'
output_match_mode: substring
name: "Curl test"
-->

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

<!-- END_STEP -->

- You should get the following output:
   ```bash
   86
   18
   1.5294117647058822
   1768
   
   {"operation":null,"total":"54","next":null}
   ```

<!-- STEP
expected_stdout_lines:
  - 'app stopped successfully: addapp'
  - 'app stopped successfully: subtractapp'
  - 'app stopped successfully: divideapp'
  - 'app stopped successfully: multiplyapp'
  - 'app stopped successfully: frontendapp'
output_match_mode: substring
name: Cleanup local
-->

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

<!-- END_STEP -->

<!-- STEP
name: "cleanup node app"
working_dir: "./node"
-->

- Uninstall node modules by navigating to the node directory and run:
  ```
  npm uninstall
  ```

<!-- END_STEP -->

## The Role of Dapr

This quickstart demonstrates how to use Dapr as a programming model for simplifying the development of distributed systems. In this quickstart, Dapr is enabling polyglot programming, service discovery and simplified state management.

### Polyglot programming

Each service in this quickstart is written in a different programming language, but they're used together in the same larger application. Dapr itself is language agnostic - none of the services have to include any dependency in order to work with Dapr. This empowers developers to build each service however they want, using the best language for the job or for a particular dev team.

### Service invocation

When the front-end server calls the respective operation services (see `server.js` code below), it doesn't need to know what IP address they live at or how they were built. Instead it calls their local dapr side-car by name, which knows how to invoke the method on the service, taking advantage of the platform’s service discovery mechanism, in this case Kubernetes DNS resolution.

The code below shows calls to the "add" and "subtract" services via the Dapr URLs:
```js
const daprUrl = `http://localhost:${daprPort}/v1.0/invoke`;

app.post('/calculate/add', async (req, res) => {
  const appResponse = await axios.post(`${daprUrl}/addapp/method/add`, req.body);
  return res.send(`${appResponse.data}`); 
});


app.post('/calculate/subtract', async (req, res) => {
  const appResponse = await axios.post(`${daprUrl}/subtractapp/method/subtract`, req.body);
  return res.send(`${appResponse.data}`); 
});
...
```

Microservice applications are dynamic with scaling, updates and failures causing services to change their network endpoints. Dapr enables you to call service endpoints with a consistent URL syntax, utilizing the hosting platform’s service discovery capabilities to resolve the endpoint location.

Learn more about Dapr [service invocation](https://docs.dapr.io/developing-applications/building-blocks/service-invocation/).

### Simplified state management

Dapr sidecars provide [state management](https://docs.dapr.io/developing-applications/building-blocks/state-management/). In this quickstart, the calculator's state is persisted each time a new button is clicked. This means a user can refresh the page, close the page or even take down the `calculator-front-end` pod, and still retain the same state when they next open it. Dapr adds a layer of indirection so that the app doesn't need to know where it's persisting state. It doesn't have to keep track of keys, handle retry logic or worry about state provider specific configuration. All it has to do is GET or POST against its Dapr sidecar's state endpoint: `http://localhost:3500/v1.0/state/${stateStoreName}`.

Take a look at `server.js` in the `react-calculator` directory. Note that it exposes two state endpoints for the React client to get and set state: the GET `/state` endpoint and the POST `/persist` endpoint. Both forward client calls to the Dapr state endpoint: 

```js
const stateUrl = `http://localhost:${daprPort}/v1.0/state/${stateStoreName}`;
```

Our client persists state by simply POSTing JSON key-value pairs (see `react-calculator/client/src/component/App.js`): 

```js
    const state = [{ 
      key: "calculatorState", 
      value 
    }];
    
    fetch("/persist", {
      method: "POST",
      body: JSON.stringify(state),
      headers: {
        "Content-Type": "application/json"
      }
    });
```

## [Optional Steps] VS Code Debugging

If you are using Visual Studio Code, you can debug this application using the preconfigured launch.json and task.json files in the .vscode folder.
The .vscode folder has already been modified in the project to allow users to launch a compound configuration called "Full Dapr App" which will run all applications and allow you to debug in VS Code.

For more information on how to configure the files visit [How-To: Debug multiple Dapr applications](https://docs.dapr.io/developing-applications/ides/vscode/vscode-how-to-debug-multiple-dapr-apps/)

> **Note**: You still need to edit your environment variables for Flask and ASPNETCORE_URLS
**Note**: Dapr offers a preview [Dapr Visual Studio Code extension](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-dapr) for local development which enables users a variety of features related to better managing their Dapr applications and debugging of your Dapr applications for all supported Dapr languages which are .NET, Go, PHP, Python and Java.
