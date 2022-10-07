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