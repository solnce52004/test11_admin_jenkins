#FROM gradle:jdk11 as builder
#FROM gradle:7.3.1-jdk11 as builder
#COPY --chown=gradle:gradle . .
#RUN ./gradlew build

#LABEL Author="solnce52004 <solnce52004@yandex.ru>"
#LABEL VERSION=0.01
#LABEL BUILD="docker build -t solnce52004/test11_admin_jenkins:0.01 ./"
#RUN docker build -t solnce52004/test11_admin_jenkins:0.01 .
#RUN docker push solnce52004/test11_admin_jenkins:0.01

#ssl
FROM openjdk:11.0.13-jdk-slim
ARG CRT_FILE=./src/main/resources/ssl/tomcat-private.crt
RUN keytool -importcert -file ${JAR_FILE}  -alias localtomcat -keystore $JAVA_HOME/jre/lib/security/cacerts -storepass changeit

FROM adoptopenjdk/openjdk11:alpine-jre
WORKDIR .
ARG JAR_FILE=./build/libs/test11_admin_jenkins-0.0.1-SNAPSHOT.jar
COPY ${JAR_FILE} app.jar

EXPOSE 4444
ENTRYPOINT ["java","-jar","app.jar"]