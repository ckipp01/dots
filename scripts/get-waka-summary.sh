#!/bin/bash
. ${HOME}/.env
. ${HOME}/bin/colors.sh
baseurl="https://wakatime.com/api/v1/"
user="ckipp01"
outputDir=${HOME}/Documents/waka-records/

echo -e "${LBLUE}Provide start date (YYYY-MM-DD): ${END}"
read startDate

echo -e "${LBLUE}Provide end date (YYYY-MM-DD): ${END}"
read endDate

echo -e "${LBLUE}Would you like to print results to file or terminal? (f/t)${END}"
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
