#FROM gradle:7.3.1-jdk11 as builder
#COPY --chown=gradle:gradle . .
#RUN ./gradlew build

#ssl
#FROM openjdk:11.0.13-jdk-slim
#WORKDIR .
#RUN ls
#ARG CRT=./src/main/resources/ssl/tomcat-private.crt
#RUN keytool -importcert -file ${CRT}  -alias localtomcat -keystore $JAVA_HOME/jre/lib/security/cacerts -storepass changeit

FROM adoptopenjdk/openjdk11:alpine-jre
WORKDIR .
RUN pwd
RUN ls
ARG JAR_FILE=./build/libs/test11_admin_jenkins-0.0.1-SNAPSHOT.jar
COPY ${JAR_FILE} app.jar

EXPOSE 4444
ENTRYPOINT ["java","-jar","app.jar"]