#!/bin/sh

printf "ADD\t\t" && curl -s http://localhost:6000/add -H Content-Type:application/json --data @operands.json | grep -Eq "^86$" && echo "✅" || echo "❌"
printf "SUBTRACT\t" && curl -s http://localhost:7001/subtract -H Content-Type:application/json --data @operands.json | grep -Eq "^18$" && echo "✅" || echo "❌"
printf "MULTIPLY\t" && curl -s http://localhost:5001/multiply -H Content-Type:application/json --data @operands.json | grep -Eq "^1768.0$" && echo "✅" || echo "❌"
printf "DIVIDE\t\t" && curl -s http://localhost:4000/divide -H Content-Type:application/json --data @operands.json | grep -Eq "^1.52941" && echo "✅" || echo "❌"