FROM arm32v7/buildpack-deps:artful-curl as builder
LABEL maintainer="Jesse Stuart <hi@jessestuart.com>"

RUN \
  curl --silent --show-error --fail --location -o /usr/bin/minio \
    "https://dl.minio.io/server/minio/release/linux-arm/minio" && \
  chmod 0755 /usr/bin/minio

# Copy just the compiled Minio binary into a busybox container, which gets us
# down to <20MB.
FROM arm32v7/busybox
COPY --from=builder /usr/bin/minio /usr/bin/minio
EXPOSE 9000
ENTRYPOINT ["minio"]
VOLUME ["/export"]
