# Use an OpenJDK 17 image
FROM openjdk:17-jdk-slim

# Set the working directory inside the container
WORKDIR /usr/app

# Copy the Spring Boot JAR file to the working directory
COPY ./target/SpringBootCICD*.jar SpringBootCICD.jar

# Expose the application port
EXPOSE 8082

# Set the entry point to run the Spring Boot application
ENTRYPOINT ["java", "-jar", "SpringBootCICD.jar"]
