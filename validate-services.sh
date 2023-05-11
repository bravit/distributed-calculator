#!/bin/bash

check() {
    curl -s http://localhost:$1/$2 -H Content-Type:application/json --data @operands.json -m 1 | grep -Eq $3 && printf "\t✅" || printf "\t❌"
}

check_both() {
    check $2 $3 $4 && check "8080" "calculate/$1/$3" $4
}

printf "\t\t\tdirect\tvia frontend"
printf "\nADD\t\tGo" && check_both go 6001 add "^86$"
printf "\nADD\t\tJava" && check_both java 6002 add "^86"
printf "\nSUBTRACT\tC#" && check_both csharp 7001 subtract "^18$"
printf "\nSUBTRACT\tPHP" && check_both php 7002 subtract "^18$"
printf "\nMULTIPLY\tPython" && check_both python 5001 multiply "^1768"
printf "\nMULTIPLY\tRust" && check_both rust 5002 multiply "^1768"
printf "\nDIVIDE\t\tNodeJS" && check_both node 4001 divide "^1.52941"
printf "\nDIVIDE\t\tKotlin" && check_both kotlin 4002 divide "^1.52941"
printf "\n"