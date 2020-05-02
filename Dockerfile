FROM adoptopenjdk/openjdk11:alpine-jre

WORKDIR /home/

# Refer to Maven build -> finalName
ARG JAR_FILE=target/ecs-fargate-demo.jar
COPY ${JAR_FILE} app.jar

EXPOSE 8080
# java -jar /home/app.jar
ENTRYPOINT ["java","-jar","app.jar"]