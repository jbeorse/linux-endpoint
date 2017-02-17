#!/bin/bash

# Set path variables
BASEPATH="/usr/local/tomcat/webapps"
ROOTPATH="$BASEPATH/ROOT"
WARPATH="$ROOTPATH.war"
LIBPATH="$ROOTPATH/WEB-INF/lib"
SETTINGSPATH="$LIBPATH/ODKAggregate-settings"
JARPATH="$SETTINGSPATH.jar"
JDBCPATH="$SETTINGSPATH/jdbc.properties"
SECURITYPATH="$SETTINGSPATH/security.properties"

# Sed replacement strings for properties
DBUSERNAME_PROP="s/jdbc\.username=.*/jdbc\.username=${DBUSERNAME:="odk_user"}/g"
DBPASSWORD_PROP="s/jdbc\.password=.*/jdbc\.password=$DBPASSWORD/g"
DBSCHEMA_PROP="s/jdbc\.schema=.*/jdbc\.schema=${DBSCHEMA:="odk_prod"}/g"
DBURL_PROP="s/jdbc\.url=.*/jdbc\.url=jdbc:postgresql:\/\/$DBURL\/odk_prod\?autoDeserialize=true/g"
SERVERURL_PROP="s/security\.server\.hostname=.*/security\.server\.hostname=$SERVERURL/g"
SERVERPORT_PROP="s/security\.server\.port=.*/security\.server\.port=${SERVERPORT:="8080"}/g"
SERVERSECUREPORT_PROP="s/security\.server\.securePort=.*/security\.server\.securePort=${SERVERSECUREPORT:="8443"}/g"


# Unzip war and jar files
rm -rf $ROOTPATH
unzip $WARPATH -d $ROOTPATH
unzip $JARPATH -d $SETTINGSPATH
rm $WARPATH
rm $JARPATH

# Update the settings with the configured values
sed -i $DBUSERNAME_PROP $JDBCPATH
sed -i $DBPASSWORD_PROP $JDBCPATH
sed -i $DBSCHEMA_PROP $JDBCPATH
sed -i $DBURL_PROP $JDBCPATH
sed -i $SERVERURL_PROP $SECURITYPATH
sed -i $SERVERPORT_PROP $SECURITYPATH
sed -i $SERVERSECUREPORT_PROP $SECURITYPATH

# Repackage the jar and war
cd $SETTINGSPATH
zip -r $JARPATH *
cd $ROOTPATH
rm -rf $SETTINGSPATH
zip -r $WARPATH *
rm -rf $ROOTPATH

# Start up tomcat
 /bin/bash /usr/local/tomcat/bin/catalina.sh run
