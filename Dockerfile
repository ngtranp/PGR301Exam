
FROM maven:3.8-openjdk-17 AS build
WORKDIR /app
# kopierer koden fra utsiden inn til imaget
COPY ./java_sqs_client .
RUN mvn package

FROM openjdk:17-slim AS prod
WORKDIR /app
# kopierer bare jar-filen for å redusere størrelsen på imaget
COPY --from=build /app/target/imagegenerator-0.0.1-SNAPSHOT.jar /app/imagegenerator-0.0.1-SNAPSHOT.jar
CMD ["sh", "-c", "java -jar imagegenerator-0.0.1-SNAPSHOT.jar 'Me on top of K2'"]
