# NOTE: Deprecated in favor of https://github.com/jessestuart/minio-multiarch

**For nightly multiarch (`amd64`, `arm64`, and `armv7`) builds, see the [updated
version](https://github.com/jessestuart/minio-multiarch) of this repo.**

### Minio Server on Docker ARM

[Minio][minio-home] is a FOSS project offering a "high performance distributed
object storage server", with fabulous features like an S3-compliant API,
excellent documentation, and out-of-the-box support for Docker, K8S, and most
major cloud providers (as well as self-hosting, of course).

One of the few things they _don't_ provide is a Docker image compatible with
ARM architectures. Luckily, it's easy enough to build our own, since they do
provide a precompiled binary for ARM (although its release cycle tends to lag
behind x64/AMD).

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
# Or to push to your Docker Hub account (or quay.io, etc) to make the image
# publicly accessible:
docker build -t {your_username}/minio-armhf .
docker push {your_username}/minio-armhf .
```

#### Kubernetes Usage

The `latest` image will work on `arm` Kubernetes out-of-the-box. However, if
you're looking to patch a recent Helm chart and get a full Minio deployment
working with a single command, you'll run into an error with the configuration
version (I'm presuming because at time of writing, the hosted ARM release is
eight months behind `master`). So to get this working, I compiled a binary from
source on native ARM. I've used the `dev` tag for this image to indicate that it
may be unstable, pulling from `master`.

Using that binary, I was able to get the deployment up and running with
something like:

```bash
$ helm install stable/minio \
  --tiller-namespace kube-system \
  --set image=jessestuart/minio-armhf,imageTag=dev
```

You can check out Minio's [docs][minio-k8s] for more info.

[minio-home]: https://minio.io
[minio-k8s]: https://docs.minio.io/docs/deploy-minio-on-kubernetes
