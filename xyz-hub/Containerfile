FROM maven:latest as builder

RUN git clone https://github.com/xyzmaps/xyz-hub.git
RUN cd xyz-hub && mvn clean install


FROM openjdk:17-slim

ENV LOG_CONFIG log4j2-console-plain.json
ENV LOG_PATH /var/log/xyz
ENV FS_WEB_ROOT www

ENV STORAGE_DB_URL jdbc:postgresql://postgres/postgres
ENV PSQL_HOST postgres
ENV XYZ_HUB_REDIS_URI redis://redis
ENV HTTP_CONNECTOR_ENDPOINT http://xyz-http-connector:9090/psql
ENV HUB_ENDPOINT http://xyz-hub:8080/hub

COPY --from=builder xyz-hub/xyz-hub-service/target/xyz-hub-service.jar .

EXPOSE 8080 9090
CMD java -jar xyz-hub-service.jar