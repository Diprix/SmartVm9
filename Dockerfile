FROM maven:3.9.6-eclipse-temurin-8 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn -q -DskipTests package

FROM tomcat:9.0-jdk8-temurin
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=build /app/target/SmartVm9-1.3-DIPRIMIO.war /usr/local/tomcat/webapps/smartwm.smartvm9.war
COPY docker/tomcat-context.xml /usr/local/tomcat/conf/Catalina/localhost/smartwm.smartvm9.xml
EXPOSE 8080
