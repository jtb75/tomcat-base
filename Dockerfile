FROM harbor.ng20.org/apache/tomcat:latest
LABEL maintainer="joe.buhr@gmail.com"
LABEL version="1.BUILDNUMBER"
LABEL business="BU-XYZ"

#ADD sample.war /usr/local/tomcat/webapps/
#ADD mazewars.war /usr/local/tomcat/webapps/


EXPOSE 8080
CMD ["catalina.sh", "run"]
