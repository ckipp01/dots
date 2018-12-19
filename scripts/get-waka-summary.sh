#!/bin/bash
. ${HOME}/.env
. ${HOME}/bin/colors.sh
baseurl="https://wakatime.com/api/v1/"
user="ckipp01"
outputDir=${HOME}/Documents/waka-records/

echo -e "${BLUE}Would you like to provide a date or a range? (d/r)${END}"
read dateFormat

if [ $dateFormat = "d" ]
then
  echo -e "${BLUE}Please provide the date (YYYY-MM-DD): ${END}"
  read date
  startDate=$date
  endDate=$date
elif [ $dateFormat = "r" ]
then
  echo -e "${BLUE}Provide start date (YYYY-MM-DD): ${END}"
  read startDate

  echo -e "${BLUE}Provide end date (YYYY-MM-DD): ${END}"
  read endDate
else
  echo -e ${GREEN}Ok, bye.${END}
  exit 0
fi

echo -e "${BLUE}Would you like to print results to file or terminal? (f/t)${END}"
read FT
case ${FT} in
  [Ff]* )
    mode=file
    ;;
  [Tt]* )
    mode=terminal
esac

echo -e "${LBLUE}Captured start date: ${BLUE}$startDate${END}"
echo -e "${LBLUE}Captured end date: ${BLUE}$endDate${END}"
echo -e "${LBLUE}Captured output mode: ${BLUE}$mode${END}"

echo -e "${LBLUE}Is this correct? (y/n)${END}"
read correct

if [ $correct = "y" ]
then
  encoded="$(echo $wakatimeAPIKey | base64)"
  case $mode in
    file)
      response=$(curl -v --header "Authorization: Basic ${encoded}" "${baseurl}users/${user}/summaries?start=${startDate}&end=${endDate}" -o ${outputDir}summary-${startDate}.json)
      echo $response
      ;;
    terminal)
      echo -e "${BLUE}Would you like a full report or just the grand total? (f/gt)${END}"
      read terminalReportType
      response=$(curl -v --header "Authorization: Basic ${encoded}" "${baseurl}users/${user}/summaries?start=${startDate}&end=${endDate}")
      if [ $terminalReportType = 'f' ]
      then
        echo $response | jq
      else
        echo $response | jq '.data[0].grand_total'
      fi
      ;;
  esac
else
  echo -e "${GREEN}Ok bye.${END}"
fi
