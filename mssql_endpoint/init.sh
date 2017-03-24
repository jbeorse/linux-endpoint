#!/bin/bash

# Set path variables
BASEPATH="/tmp"
WARPATH="$BASEPATH/ODKAggregate.war"
ROOTPATH="$BASEPATH/ODKAggregate"
SETTINGSNAME="odk-settings-latest"
SETTINGSPATH="$BASEPATH/$SETTINGSNAME"
SETTINGSJARPATH="$ROOTPATH/WEB-INF/lib/$SETTINGSNAME.jar"
SECURITYPATH="$SETTINGSPATH/security.properties"
JDBCPATH="$SETTINGSPATH/jdbc.properties"
RESULTPATH="/usr/local/tomcat/webapps/ROOT"

# Sed replacement strings for properties
## Server hostname
SERVERURL_PROP="s/security\.server\.hostname=.*/security\.server\.hostname=$SERVERURL/g"
## Server port
SERVERPORT_PROP="s/security\.server\.port=.*/security\.server\.port=${SERVERPORT:="8080"}/g"
## Secure server port
SERVERSECUREPORT_PROP="s/security\.server\.securePort=.*/security\.server\.securePort=${SERVERSECUREPORT:="8443"}/g"
## JDBC URL
JDBCURL_PROP="s/jdbc\.url=.*/jdbc\.url=jdbc:sqlserver:\/\/$DBURL;database=$DBNAME;user=${DBUSERNAME:="odk_user"};password=$DBPASSWORD;encrypt=true;trustServerCertificate=${TRUSTSERVERCERT:="false"};hostNameInCertificate=${SERVERHOSTINCERT:="*.database.windows.net"};loginTimeout=30;authentication=ActiveDirectoryPassword/g"
## Database Schema
DBSCHEMA_PROP="s/jdbc\.schema=.*/jdbc\.schema=${DBSCHEMA:="odk_prod"}/g"


# Unzip war and jar files
unzip $WARPATH -d $ROOTPATH
unzip $SETTINGSJARPATH -d $SETTINGSPATH
rm $SETTINGSJARPATH

# Update the settings with the configured values
sed -i $SERVERURL_PROP $SECURITYPATH
sed -i $SERVERPORT_PROP $SECURITYPATH
sed -i $SERVERSECUREPORT_PROP $SECURITYPATH
sed -i $JDBCURL_PROP $JDBCPATH
sed -i $DBSCHEMA_PROP $JDBCPATH

# Repackage the jar and war
cd $SETTINGSPATH
zip -r $SETTINGSJARPATH *
mkdir $RESULTPATH
cp -r $ROOTPATH/* $RESULTPATH


# Start up tomcat
 /bin/bash /usr/local/tomcat/bin/catalina.sh run
