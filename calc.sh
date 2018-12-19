#!/bin/bash

set -u



YEARS_BEFORE=1
YEARS_AHEAD=10


CUR_YEAR="$(date +%Y)"
#echo $CUR_YEAR
#echo '----'




function cal_line {
  local YEAR=$1
  local MODE=$2

  local ORIGIN="$( cal $YEAR | tail -n +2 )"

  local I=
  for (( I=CUR_YEAR-YEARS_BEFORE ; I<CUR_YEAR+YEARS_AHEAD; I++ )); do
    if [ "$MODE" == 'title' ]; then
      DATA=$I
    else
      local CANDIDATE="$( cal $I | tail -n +2 )"
      if [ "${ORIGIN}" == "${CANDIDATE}" ]; then
        local DATA='  \e[0;31m*\e[0m  '
      else
        local DATA=''
      fi
    fi
    printf -v OUT "|%5s" "$DATA" # $YEAR"hhhhhh

    
    echo -ne "${OUT}"
  done
}

echo -n '     | '
cal_line 2018 'title'
echo

for (( I=CUR_YEAR-YEARS_BEFORE ; I<CUR_YEAR+YEARS_AHEAD; I++ )); do
  echo -n "$I | "
  cal_line $I 'data'
  echo
done
