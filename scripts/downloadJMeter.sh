#!/bin/bash

JMETER_DIR="$1"
JMETER_URL="http://www.mirrorservice.org/sites/ftp.apache.org/jmeter/binaries/apache-jmeter-3.0.tgz"

white=`tput setaf 7`
reset=`tput sgr0`

function install_jmeter() {
    echo "${white}Downloading Apache JMeter from ${JMETER_URL}${reset}"
    curl -o jmeter.tgz ${JMETER_URL}
    tar -xzf ./jmeter.tgz
    rm -rf ./jmeter.tgz
    mv apache-jmeter-* ${JMETER_DIR}
    echo "${white}Apache JMeter has been installed under ${JMETER_DIR}${reset}"
    echo "jmeter.save.saveservice.output_format=xml" >> ${JMETER_DIR}/bin/jmeter.properties
    echo "CookieManager.delete_null_cookies=false
          CookieManager.save.cookies=true
          CookieManager.check.cookies=false" >> ${JMETER_DIR}/bin/user.properties
}

if [[ -z "$1" || "$1" == "-h" ]]
then
    echo "Usage: downloadJMeter.sh installation_path"
    exit 1
fi

if [ ! -e ${JMETER_DIR} ]
then
    install_jmeter
else
    echo "${white}Apache JMeter is already installed at ${JMETER_DIR}${reset}"
fi
