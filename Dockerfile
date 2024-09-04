# Use an official Tomcat runtime as a parent image
FROM tomcat:9.0-jdk11

# Set environment variables
ENV JAVA_OPTS="-Djava.security.egd=file:/dev/./urandom"

# Copy the WAR file to the webapps directory
# Assuming the WAR file is generated and located at 'target/your-app.war'
COPY target/web-calculator.war /usr/local/tomcat/webapps/ROOT.war

# Expose the default port 8080
EXPOSE 8080

# Run Tomcat
CMD ["catalina.sh", "run"]