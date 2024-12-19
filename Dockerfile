FROM openjdk:17

COPY ./target/SpringBootCICD*.jar /usr/app/SpringBootCICD.jar

WORKDIR /usr/app

EXPOSE 8082

ENTRYPOINT ["java","-jar","SpringBootCICD.jar"]