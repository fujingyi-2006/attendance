FROM tomcat:9.0-jdk11-corretto

RUN rm -rf /usr/local/tomcat/webapps/ROOT \
           /usr/local/tomcat/webapps/docs \
           /usr/local/tomcat/webapps/examples \
           /usr/local/tomcat/webapps/host-manager \
           /usr/local/tomcat/webapps/manager

COPY web/ /usr/local/tomcat/webapps/ROOT/
COPY src/attendance/Attend.java /tmp/Attend.java

RUN mkdir -p /usr/local/tomcat/webapps/ROOT/WEB-INF/classes/attendance \
    && javac -cp /usr/local/tomcat/lib/servlet-api.jar \
             -d /usr/local/tomcat/webapps/ROOT/WEB-INF/classes \
             /tmp/Attend.java \
    && rm /tmp/Attend.java

COPY entrypoint.sh /usr/local/tomcat/bin/entrypoint.sh
RUN chmod +x /usr/local/tomcat/bin/entrypoint.sh

EXPOSE 8080
CMD ["/usr/local/tomcat/bin/entrypoint.sh"]
