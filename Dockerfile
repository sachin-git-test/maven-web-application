#===================== Stage 1: Build ===========================
FROM maven:3.9.14-eclipse-temurin-17 AS mavenstage
WORKDIR /app
COPY . .
RUN mvn clean package

#===================== Stage 2: Runtime =========================
FROM tomcat:9.0-jdk17

# Copy WAR from build stage
COPY --from=mavenstage /app/target/maven-web-application.war /usr/local/tomcat/webapps/

# Metadata
MAINTAINER ME

EXPOSE 8080

CMD ["catalina.sh", "run"]
