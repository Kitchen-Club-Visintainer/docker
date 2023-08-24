FROM maven:3.9.3-amazoncorretto-17 AS BUILD
WORKDIR /opt/var

COPY pom.xml .
RUN mvn dependency:go-offline

# Copia o restante do projeto para o diretório de trabalho
COPY src ./src
RUN mvn clean install


##FROM amazoncorretto:17.0.8-al2023-headless
#FROM amazoncorretto:17
#COPY --from=BUILD /opt/var/target/api.jar .
##COPY /target/api.jar .

ENTRYPOINT ["java", "-jar", "-Dspring.profiles.active=homol","target/api.jar"]

# Comando para manter o container em execução
##CMD ["sh", "-c", "while true; do echo 'teste'; sleep 1; done"]
