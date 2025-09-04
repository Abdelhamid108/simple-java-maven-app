FROM maven:3.9.9-eclipse-temurin-17 AS builder

WORKDIR /app

COPY ./*.xml ./

COPY src ./src

RUN ["mvn", "clean", "package"]

FROM eclipse-temurin:17-jdk-alpine AS runtime

WORKDIR /app/app

COPY --from=builder /app/target/*.jar app.jar 

ENTRYPOINT ["java", "-jar", "app.jar"]

