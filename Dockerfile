FROM eclipse-temurin:21-jre-alpine
WORKDIR /app  
RUN apk update && apk upgrade --no-cache
COPY target/java-devsecops-demo-1.0.0-SNAPSHOT.jar app.jar  
EXPOSE 8080  
ENTRYPOINT ["java", "-jar", "app.jar"]  
