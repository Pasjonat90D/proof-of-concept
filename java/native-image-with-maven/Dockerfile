FROM ghcr.io/graalvm/native-image:ol8-java17-22 AS builder

WORKDIR /build

COPY . /build

RUN ./mvnw -Pnative native:compile

FROM docker.io/oraclelinux:8-slim

EXPOSE 8080

COPY --from=builder /build/target/native-image-with-maven .
ENTRYPOINT ["/native-image-with-maven"]
