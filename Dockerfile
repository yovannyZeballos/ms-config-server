FROM gradle:7.6.1-jdk17 AS builder
COPY build.gradle .
COPY src ./src
RUN gradle build -x test

FROM eclipse-temurin:17-jdk-alpine
WORKDIR /app
COPY --from=builder /home/gradle/build/libs/ms-config-server-*SNAPSHOT.jar ms-config-server.jar
EXPOSE 7777
#ENV GIT_TOKEN=null URL_EUREKA=null
ENTRYPOINT ["sh", "-c", "cd /app && java -Djava.file.encoding=UTF-8 -jar ms-config-server.jar"]