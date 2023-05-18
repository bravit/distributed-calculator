#!/bin/sh

if [ $# -lt 1 ]
then
        echo "Usage : $0 SERVICE-NAME"
        exit
fi

case $1 in
    java-calc )
        cd java && dapr run --app-id java-calc --app-port 6002 --dapr-http-port 3506 ./gradlew run ;;
    kotlin-calc )
        cd kotlin && dapr run --app-id kotlin-calc --app-port 4002 --dapr-http-port 3509 ./gradlew run ;;
    go-calc )
        cd go && dapr run --app-id go-calc --app-port 6001 --dapr-http-port 3503 go run app.go ;;
    python-calc )
        cd python && dapr run --app-id python-calc --app-port 5001 --dapr-http-port 3501 pipenv run flask run ;;
    php-calc )
        cd php && dapr run --app-id php-calc --app-port 7002 --dapr-http-port 3504 -- php -S 0.0.0.0:7002 -t public ;;
    rust-calc )
        cd rust && dapr run --app-id rust-calc --app-port 5002 --dapr-http-port 3508 cargo run ;;
    node-calc )
        cd node && dapr run --app-id node-calc --app-port 4001 --dapr-http-port 3502 node app.js ;;
    csharp-calc )
        cd csharp && dapr run --app-id csharp-calc --app-port 7001 --dapr-http-port 3505 dotnet run ;;
    cpp-calc )
        cd cpp && dapr run --app-id cpp-calc --app-port 6003 --dapr-http-port 3510 bin/cpp-calc ;;
    frontendapp )
        cd react-calculator && dapr run --app-id frontendapp --app-port 8080 --dapr-http-port 3507 node server.js ;;
    *)
        echo "Unknown service"
esac
