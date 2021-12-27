#FROM gradle:7.3.1-jdk11 as builder
#COPY --chown=gradle:gradle . .
#RUN ./gradlew build

#ssl
#FROM openjdk:11.0.13-jdk-slim
#RUN "keytool -importcert -file ./tomcat-private.crt -alias localtomcat -cacerts -keystore /usr/lib/jvm/java-11-openjdk-amd64/lib/security/cacerts -keypass Zerkalo82 -storepass changeit"

FROM adoptopenjdk/openjdk11:alpine-jre
WORKDIR .

ARG CERT="tomcat-private.crt"
COPY $CERT .
RUN keytool -importcert -file $CERT -alias tomcat -cacerts -storepass changeit -noprompt

ARG JAR_FILE=./build/libs/test11_admin_jenkins-0.0.1-SNAPSHOT.jar
COPY ${JAR_FILE} app.jar

EXPOSE 4444
ENTRYPOINT ["java", "-jar","app.jar"]