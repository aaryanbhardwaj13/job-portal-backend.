# ---- Build stage ----
FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# ---- Runtime stage ----
FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=build /app/target/JobPortal-0.0.1-SNAPSHOT.jar JobPortal.jar
EXPOSE 8080
ENTRYPOINT ["sh","-c","java -Djdk.tls.client.protocols=TLSv1.2 -Dserver.port=${PORT:-8080} -jar JobPortal.jar"]
