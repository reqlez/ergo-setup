FROM hseeberger/scala-sbt:eclipse-temurin-11.0.13_1.5.8_2.12.15 as builder
COPY . /explorer-backend
WORKDIR /explorer-backend
RUN sbt update
RUN sbt utx-tracker/assembly
RUN mv `find . -name UtxTracker-assembly-*.jar` /utx-tracker.jar
CMD ["/usr/bin/java", "-jar", "/utx-tracker.jar"]

FROM eclipse-temurin:11-jre-jammy
ENV MAX_HEAP 1G
ENV _JAVA_OPTIONS "-Xms${MAX_HEAP} -Xmx${MAX_HEAP}"
COPY --from=builder /utx-tracker.jar /utx-tracker.jar
ENTRYPOINT java -jar /utx-tracker.jar $0
