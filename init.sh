#!/bin/bash

# Set path variables
BASEPATH="/usr/local/tomcat/webapps"
ROOTPATH="$BASEPATH/ROOT"
WARPATH="$ROOTPATH.war"
LIBPATH="$ROOTPATH/WEB-INF/lib"
SETTINGSPATH="$LIBPATH/ODKAggregate-settings"
JARPATH="$SETTINGSPATH.jar"
PROPERTIESPATH="$SETTINGSPATH/jdbc.properties"

# Sed replacement strings for properties
DBUSERNAME_PROP="s/jdbc\.username=.*/jdbc\.username=${DBUSERNAME:="odk_user"}/g"
DBPASSWORD_PROP="s/jdbc\.password=.*/jdbc\.password=$DBPASSWORD/g"
DBSCHEMA_PROP="s/jdbc\.schema=.*/jdbc\.schema=${DBSCHEMA:="odk_prod"}/g"
DBURL_PROP="s/jdbc\.url=.*/jdbc\.url=jdbc:postgresql:\/\/$DBURL\/odk_prod\?autoDeserialize=true/g"

# Unzip war and jar files
rm -rf $ROOTPATH
unzip $WARPATH -d $ROOTPATH
unzip $JARPATH -d $SETTINGSPATH
rm $WARPATH
rm $JARPATH


# Update the settings with the configured values
sed -i $DBUSERNAME_PROP $PROPERTIESPATH
sed -i $DBPASSWORD_PROP $PROPERTIESPATH
sed -i $DBSCHEMA_PROP $PROPERTIESPATH
sed -i $DBURL_PROP $PROPERTIESPATH

# Repackage the jar and war
cd $SETTINGSPATH
zip -r $JARPATH *
cd $ROOTPATH
rm -rf $SETTINGSPATH
zip -r $WARPATH *
rm -rf $ROOTPATH

# Start up tomcat
/bin/bash /usr/local/tomcat/bin/catalina.sh run

