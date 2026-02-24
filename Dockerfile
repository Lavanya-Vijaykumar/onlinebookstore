# Use official OpenJDK 17 image
FROM openjdk:17-slim

# Set working directory
WORKDIR /app

# Copy WAR file and dependencies
COPY target/onlinebookstore.war /app/onlinebookstore.war
COPY target/dependency/webapp-runner.jar /app/webapp-runner.jar

# Expose port
EXPOSE 8080

# Run the app
ENTRYPOINT ["java", "-jar", "/app/webapp-runner.jar", "--port", "8080", "/app/onlinebookstore.war"]
