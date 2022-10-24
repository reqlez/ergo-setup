FROM hseeberger/scala-sbt:eclipse-temurin-11.0.13_1.5.8_2.12.15 as builder
COPY . /explorer-backend
WORKDIR /explorer-backend
RUN sbt update
RUN sbt utx-broadcaster/assembly
RUN mv `find . -name UtxBroadcaster-assembly-*.jar` /utx-broadcaster.jar
CMD ["/usr/bin/java", "-jar", "/utx-broadcaster.jar"]

FROM eclipse-temurin:11-jre-jammy
ENV MAX_HEAP 1G
ENV _JAVA_OPTIONS "-Xms${MAX_HEAP} -Xmx${MAX_HEAP}"
COPY --from=builder /utx-broadcaster.jar /utx-broadcaster.jar
ENTRYPOINT java -jar /utx-broadcaster.jar $0
