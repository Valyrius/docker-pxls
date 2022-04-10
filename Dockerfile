FROM adoptopenjdk/openjdk16:alpine as builder
RUN apk --no-cache add build-base maven git \
  && git clone https://github.com/pxlsspace/Pxls.git \
  && cd Pxls/ \
  && mvn clean package\
  && rm -rf node node_modules

FROM adoptopenjdk/openjdk16:alpine-jre
COPY --from=builder /Pxls /Pxls
WORKDIR /Pxls
CMD [ "java", "-jar", "target/pxls-1.0-SNAPSHOT.jar" ]
