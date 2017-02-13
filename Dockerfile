FROM tomcat

RUN ["rm", "-fr", "/usr/local/tomcat/webapps/ROOT"]
COPY ROOT.war /usr/local/tomcat/webapps/ROOT.war
COPY postgresql-9.4.1212.jar /usr/local/tomcat/lib

CMD ["catalina.sh", "run"]
