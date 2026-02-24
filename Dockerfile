# Use OpenJDK 17
FROM openjdk:17

# Set working directory inside container
WORKDIR /app

# Copy the WAR file built by Maven
COPY target/onlinebookstore.war /app/onlinebookstore.war

# Copy webapp-runner jar (already downloaded by Maven)
COPY target/dependency/webapp-runner.jar /app/webapp-runner.jar

# Expose the port
EXPOSE 8080

# Command to run the WAR using webapp-runner
CMD ["java", "-jar", "webapp-runner.jar", "--port", "8080", "onlinebookstore.war"]
