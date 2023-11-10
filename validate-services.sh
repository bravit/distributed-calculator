#!/bin/bash

check() {
    curl -s http://localhost:$1/$2 -H Content-Type:application/json --data @operands.json -m 1 | grep -Eq $3 && printf "✅ " || printf "❌ "
}

check_both() {
    check $2 $3 $4 && check "8080" "calculate/$1/$3" $4
}



printf "\n\tADD\tSUBTRACT\tMULTIPLY\tDIVIDE"
printf "\nGo\t" && check_both go 6001 add "^86$"
printf "\nJava\t" && check_both java 6002 add "^86" && printf "\t\t\t" && check_both java 6002 multiply "^1768"
printf "\nC++\t" && check_both cpp 6003 add "^86" && printf "\t" && check_both cpp 6003 subtract "^18$"
printf "\nC#\t" && printf "\t" && check_both csharp 7001 subtract "^18$"
printf "\nPHP\t" && printf "\t" && check_both php 7002 subtract "^18$"
printf "\nPython\t" && printf "\t" && printf "\t\t" && check_both python 5001 multiply "^1768"
printf "\nRust\t" && printf "\t" && printf "\t\t" && check_both rust 5002 multiply "^1768" && printf "\t\t" && check_both rust 5002 divide "^1.52941"
printf "\nNodeJS" && printf "\t\t\t\t\t\t" && check_both node 4001 divide "^1.52941"
printf "\nKotlin" && printf "\t\t\t\t\t\t" && check_both kotlin 4002 divide "^1.52941"
printf "\n"