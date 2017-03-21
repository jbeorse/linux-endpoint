FROM tomcat:8.5.12

RUN ["rm", "-fr", "/usr/local/tomcat/webapps/ROOT"]
COPY ROOT.war /usr/local/tomcat/webapps/ROOT.war
COPY init.sh /usr/local/tomcat/webapps/init.sh
COPY mezuricloud-perhaps-same.cer /tmp/mezuricloud-perhaps-same.cer
COPY cert.sh /tmp/cert.sh

RUN apt-get update
RUN apt-get install -y zip

RUN keytool -noprompt -import -trustcacerts -alias mezuricloud -keystore "/usr/lib/jvm/java-8-openjdk-amd64/jre/lib/security/cacerts" -file /tmp/mezuricloud-perhaps-same.cer -storepass changeit

CMD ["/usr/local/tomcat/webapps/init.sh", ""]
