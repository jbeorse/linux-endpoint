FROM tomcat

RUN ["rm", "-fr", "/usr/local/tomcat/webapps/ROOT"]
COPY ROOT.war /usr/local/tomcat/webapps/ROOT.war
COPY postgresql-9.4.1212.jar /usr/local/tomcat/lib
COPY init.sh /usr/local/tomcat/webapps/init.sh

RUN apt-get update && apt-get install zip

CMD ["/usr/local/tomcat/webapps/init.sh", ""]
