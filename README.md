# nextcloud-ocr-smb

[![Build](https://github.com/welworx/nextcloud-ocr-smb/actions/workflows/build.yml/badge.svg)](https://github.com/welworx/nextcloud-ocr-smb/actions/workflows/build.yml)
[![Image](https://img.shields.io/badge/ghcr.io-nextcloud--ocr--smb-blue?logo=github)](https://github.com/welworx/nextcloud-ocr-smb/pkgs/container/nextcloud-ocr-smb)
[![Based on Nextcloud](https://img.shields.io/badge/based%20on-Nextcloud-0082C9?logo=nextcloud&logoColor=white)](https://nextcloud.com)
[![License](https://img.shields.io/github/license/welworx/nextcloud-ocr-smb)](LICENSE)

**[Nextcloud](https://nextcloud.com) Docker image with OCR and SMB support built in** —
a drop-in replacement for the official `nextcloud:stable-apache` image.

Adds `tesseract-ocr` (eng+deu), `ocrmypdf`, `imagemagick`, `ffmpeg`, and the
`smbclient` PHP extension (for external storage / `files_external` SMB mounts).
`default_phone_region` is preset to `AT`.

## Image

```
ghcr.io/welworx/nextcloud-ocr-smb:latest
ghcr.io/welworx/nextcloud-ocr-smb:stable-apache
ghcr.io/welworx/nextcloud-ocr-smb:<nextcloud-version>-apache   # e.g. 28.0.1-apache
```

Tags mirror the upstream `nextcloud` image's own tagging scheme (version-apache /
stable-apache / latest). GitHub Actions rebuilds and re-tags daily — via a cache-bust
build-arg, `apt-get update`/`install` re-runs every day even if the upstream Nextcloud
image itself hasn't changed, so `latest`/`stable-apache` stay current on both fronts.
`<version>-apache` tags accumulate one per Nextcloud release actually built.

## Usage

Drop-in replacement for `nextcloud:stable-apache` in your `docker-compose.yml`:

```yaml
services:
  app:
    image: ghcr.io/welworx/nextcloud-ocr-smb:stable-apache
    # ... same volumes/env as the official image
```

## Supply chain

Every build in [`.github/workflows/build.yml`](.github/workflows/build.yml):

- lints the `Dockerfile` with [hadolint](https://github.com/hadolint/hadolint)
- scans the image with [Trivy](https://github.com/aquasecurity/trivy), results in this
  repo's [Security tab](../../security/code-scanning) (report-only — the image carries
  a full Debian + Python dependency tree via `ocrmypdf`, so it isn't gated on CVEs that
  are upstream's to fix, not this Dockerfile's)
- attaches an SBOM and build provenance attestation to each pushed image
- signs each pushed image keylessly with [cosign](https://github.com/sigstore/cosign)
  via GitHub OIDC (no stored signing key)

Verify a pulled image:

```
cosign verify ghcr.io/welworx/nextcloud-ocr-smb:stable-apache \
  --certificate-identity-regexp 'https://github.com/welworx/nextcloud-ocr-smb/.github/workflows/build.yml@.*' \
  --certificate-oidc-issuer https://token.actions.githubusercontent.com
```

Third-party Actions used in the workflow are pinned to commit SHA (not a mutable tag),
and Dependabot keeps those pins current.

## License and disclaimer

This repository is unofficial and not affiliated with, endorsed by, or sponsored
by Nextcloud GmbH; "Nextcloud" is a trademark of Nextcloud GmbH. It builds
[nextcloud/docker](https://github.com/nextcloud/docker) unmodified as its base
image and adds a thin OCR/SMB layer on top — licensed [AGPL-3.0](LICENSE), the
same license as the upstream `nextcloud/docker` repo it extends. The image is
provided as-is, without warranty; see the license for details.
