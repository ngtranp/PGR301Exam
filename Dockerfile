
# Stage 1: Build the application
FROM maven:3.9.4-eclipse-temurin-17 AS builder

# Set the working directory
WORKDIR /app

# Copy the Maven project files to the working directory
COPY pom.xml .
COPY src ./src

# Build the application
RUN mvn package -DskipTests

# Stage 2: Create a minimal runtime environment
FROM eclipse-temurin:17-jre-alpine

# Set the working directory
WORKDIR /app

# Copy the JAR file from the builder stage
COPY --from=builder /app/target/imagegenerator-0.0.1-SNAPSHOT.jar /app/imagegenerator.jar

# Set the environment variable for SQS_QUEUE_URL
ENV SQS_QUEUE_URL=""
ENV java-sqs-client="Me on top of K2"

# Command to run the application
ENTRYPOINT ["java", "-jar", "/app/imagegenerator.jar"]
