#FROM gradle:7.3.1-jdk11 as builder
#COPY --chown=gradle:gradle . .
#RUN ./gradlew build

FROM adoptopenjdk/openjdk11:alpine-jre
WORKDIR .
ARG JAR_FILE=./build/libs/test11_admin_jenkins-0.0.1-SNAPSHOT.jar
COPY ${JAR_FILE} app.jar

EXPOSE 4444
ENTRYPOINT ["java", "-Djavax.net.ssl.trustStore=/usr/lib/jvm/java-11-openjdk-amd64/lib/security/cacerts", "-Djavax.net.ssl.trustStorePassword=changeit", "-jar","app.jar"]