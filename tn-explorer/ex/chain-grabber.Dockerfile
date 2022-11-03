FROM hseeberger/scala-sbt:eclipse-temurin-11.0.13_1.5.8_2.12.15 as builder
COPY . /explorer-backend 
WORKDIR /explorer-backend
RUN sbt update
RUN sbt chain-grabber/assembly
RUN mv `find . -name ChainGrabber-assembly-*.jar` /chain-grabber.jar
CMD ["/usr/bin/java", "-jar", "/chain-grabber.jar"]

FROM eclipse-temurin:11-jre-jammy
ENV MAX_HEAP 1G
ENV _JAVA_OPTIONS "-Xms${MAX_HEAP} -Xmx${MAX_HEAP}"
COPY --from=builder /chain-grabber.jar /chain-grabber.jar
ENTRYPOINT java -jar /chain-grabber.jar $0
