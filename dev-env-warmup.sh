#!/bin/sh
./deps.sh
cd go
go build .
cd ../java
./gradlew build
cd ../kotlin
./gradlew build
cd ../rust
cargo build