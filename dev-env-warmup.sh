#!/bin/sh
cd go
go build .
cd ../python
pipenv install
cd ../csharp
export ASPNETCORE_URLS="http://localhost:7001"
dotnet build
cd ../node
npm install
cd ../react-calculator
npm install
npm run buildclient
cd ../java
./gradlew build
cd ../kotlin
./gradlew build
cd ../rust
cargo build