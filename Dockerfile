FROM maven:3.8.3-openjdk-16 as builder
RUN git clone https://github.com/pxlsspace/Pxls.git; \
  cd Pxls/; \
  mvn clean package; \
  cp target/pxls*.jar /mnt/pxls.jar; \
  cp -r resources/ /mnt;

FROM adoptopenjdk/openjdk16:alpine-jre
COPY --from=builder /mnt /Pxls
WORKDIR /Pxls
CMD [ "java", "-jar", "pxls.jar" ]
