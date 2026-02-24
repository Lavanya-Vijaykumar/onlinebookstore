# Use OpenJDK 17
FROM openjdk:17

# Set workdir
WORKDIR /app

# Copy WAR and webapp-runner
COPY target/onlinebookstore.war /app/onlinebookstore.war
COPY target/dependency/webapp-runner.jar /app/webapp-runner.jar

# Expose port
EXPOSE 8080

# Run WAR with webapp-runner
CMD ["java","-jar","webapp-runner.jar","--port","8080","onlinebookstore.war"]
