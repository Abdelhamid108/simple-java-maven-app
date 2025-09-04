# Stage 1: Build the Java application using Maven
FROM maven:3.9.9-eclipse-temurin-21 AS builder

# Set working directory inside the container
WORKDIR /app

# Copy the Maven configuration file(s) to download dependencies
COPY ./*.xml ./

# Copy the source code into the container
COPY src ./src

# Run Maven to clean, compile, and package the application into a JAR
RUN ["mvn", "clean", "package"]

# Stage 2: Create a lightweight runtime image with only the JDK
FROM eclipse-temurin:21-jdk-alpine AS runtime

# Set working directory for the runtime container
WORKDIR /app/app

# Copy the built JAR from the builder stage into the runtime image
COPY --from=builder /app/target/*.jar app.jar 

# Set the default command to run the Java application
ENTRYPOINT ["java", "-jar", "app.jar"]
