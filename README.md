### Minio Server on Docker ARM

[Minio][minio-home] is an OSS project offering a "high performance distributed object
storage server", with fabulous features like an S3-compliant API, excellent
documentation, and out-of-the-box support for Docker, K8S, and most major
cloud providers (as well as self-hosting, of course).

One of the few things they *don't* provide is a ready-to-run Docker image
compatible with ARM architectures. Luckily, it's easy enough to build our own,
since they do provide a precompiled binary for ARM (although its release cycle
tends to lag behind x64/AMD).

### How can I use this?
You can run the following command on an ARM-based system to stand up
a standalone instance of Minio Server on Docker:

```bash
docker run \
  -v /export/minio \
  -v /export/minio-config:/root/.minio \
  -p 9000:9000 \
  jessestuart/minio-armhf server /export
```

Alternatively, you can build locally to ensure you're pulling the latest stable
binary:

```bash
git clone https://github.com/jessestuart/minio-armhf
cd minio-armhf
docker build -t minio-armhf .
# ---------------------------------------
# Or to push to your Docker Hub (or quay.io, etc) account to make the image
# publicly accessible:
docker build -t {your_username}/minio-armhf .
docker push {your_username}/minio-armhf .
```

This image can also be used to deploy a Minio pod to a Kubernetes cluster.
See the [docs][minio-k8s] for more detail.

[minio-home]: https://minio.io
[minio-k8s]: https://docs.minio.io/docs/deploy-minio-on-kubernetes
