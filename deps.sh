#!/bin/sh
cd python
pipenv install
cd ../node
npm install
cd ../php
composer update
cd ../react-calculator
npm install
npm run buildclient
cd ../cpp
conan profile detect
conan install . -of cmake-build-release --build=missing
cmake . -DCMAKE_TOOLCHAIN_FILE=cmake-build-release/conan_toolchain.cmake -DCMAKE_BUILD_TYPE=Release