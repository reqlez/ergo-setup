FROM hseeberger/scala-sbt:eclipse-temurin-11.0.13_1.5.8_2.12.15 as builder
COPY . /explorer-backend
WORKDIR /explorer-backend
RUN sbt update
RUN sbt explorer-api/assembly
RUN mv `find . -name ExplorerApi-assembly-*.jar` /explorer-api.jar
CMD ["/usr/bin/java", "-jar", "/explorer-api.jar"]

FROM eclipse-temurin:11-jre-jammy
ENV MAX_HEAP 8G
ENV _JAVA_OPTIONS "-Xms${MAX_HEAP} -Xmx${MAX_HEAP}"
COPY --from=builder /explorer-api.jar /explorer-api.jar
ENTRYPOINT java -jar /explorer-api.jar $0
