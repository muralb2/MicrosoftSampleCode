# ---------- Build Stage ----------
FROM gradle:8.2.1-jdk17 AS build

WORKDIR /app

# Copy project files
COPY . .

# Build the project and create the JAR
RUN gradle clean build -x test

# ---------- Runtime Stage ----------
FROM openjdk:17-jdk-slim

WORKDIR /app

# Copy JAR from build stage (adjust name if needed)
COPY --from=build /app/build/libs/*.jar app.jar

# Run the application
CMD ["java", "-jar", "app.jar"]
