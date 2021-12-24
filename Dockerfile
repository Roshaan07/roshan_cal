FROM maven:3.8-openjdk-8-slim as build
RUN mkdir /cal
WORKDIR /cal
COPY . .
RUN mvn clean package


FROM tomcat:9
RUN mv webapps webapps2
RUN cp -r webapps.dist/ webapps
COPY --from=deploy /java/target/WebAppCal-0.0.8.war /usr/local/tomcat/webapps/
