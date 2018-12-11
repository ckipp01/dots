#!/bin/bash
. ${HOME}/.env
. ${HOME}/bin/colors.sh
baseurl="https://wakatime.com/api/v1/"
user="ckipp01"
outputDir=${HOME}/Documents/waka-records/

echo -e "${BLUE}Provide start date (YYYY-MM-DD): ${END}"
read startDate

echo -e "${BLUE}Provide end date (YYYY-MM-DD): ${END}"
read endDate

echo -e "${BLUE}Would you like to print results to file or terminal? (f/t)${END}"
read FT
case ${FT} in
  [Ff]* )
    mode=file
    ;;
  [Tt]* )
    mode=terminal
esac

echo -e "${BLUE}Captured start date: $startDate${END}"
echo -e "${BLUE}Captured end date: $endDate${END}"
echo -e "${BLUE}Captured output mode: $mode${END}"

echo -e "${BLUE}Is this correct? (y/n)${END}"
read correct

if [ $correct = "y" ]
then
  encoded="$(echo $wakatimeAPIKey | base64)"
  case $mode in
    file)
      response=$(curl -v --header "Authorization: Basic ${encoded}" "${baseurl}users/${user}/summaries?start=${startDate}&end=${endDate}" > ${outputDir}summary-${startDate}.json)
      echo $response
      ;;
    terminal)
      response=$(curl -v --header "Authorization: Basic ${encoded}" "${baseurl}users/${user}/summaries?start=${startDate}&end=${endDate}")
      echo $response | jq
      ;;
  esac
else
  echo -e "${GREEN}Ok bye.${END}"
fi
