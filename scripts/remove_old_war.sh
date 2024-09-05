#!/bin/bash
# Remove the existing WAR file
if [ -f /opt/tomcat/webapps/web-calculator.war ]; then
  rm /opt/tomcat/webapps/ROOT.war
fi

# Remove the exploded directory if it exists
if [ -d /opt/tomcat/webapps/web-calculator ]; then
  rm -rf /opt/tomcat/webapps/ROOT
fi
