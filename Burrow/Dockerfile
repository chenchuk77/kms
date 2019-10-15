# stage 1: builder
FROM golang:1.13-alpine as builder
ENV BURROW_SRC /usr/src/Burrow/
RUN apk add --no-cache git curl
COPY . $BURROW_SRC
WORKDIR $BURROW_SRC
RUN go mod tidy && go build -o /tmp/burrow .

# stage 2: runner
FROM alpine:3.10
LABEL maintainer="LinkedIn Burrow https://github.com/linkedin/Burrow"
ARG BURROW_KAFKA_BROKERS
ARG BURROW_ZK_CONN
COPY --from=builder /tmp/burrow /app/
ADD /docker-config/burrow.toml /app/config/burrow.toml

# set kafka brokers when build the image
RUN sed -i "s/\[ \"kafka:9092\" \]/${BURROW_KAFKA_BROKERS}/g" /app/config/burrow.toml && \
    sed -i "s/\[ \"zookeeper:2181\" \]/${BURROW_ZK_CONN}/g" /app/config/burrow.toml


CMD ["/app/burrow", "--config-dir", "/app/config"]

