# Dockerfile
# Use a working OpenJDK 17 image
FROM openjdk:17-jdk

# Set working directory
WORKDIR /app

# Copy WAR and webapp-runner jar
COPY target/onlinebookstore.war /app/onlinebookstore.war
COPY target/dependency/webapp-runner.jar /app/webapp-runner.jar

# Expose port
EXPOSE 8080

# Run the WAR using webapp-runner
CMD ["java", "-jar", "webapp-runner.jar", "--port", "8080", "onlinebookstore.war"]
