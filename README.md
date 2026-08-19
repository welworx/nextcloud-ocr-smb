# nextcloud-ocr-smb

`nextcloud:stable-apache` with `tesseract-ocr` (eng+deu), `ocrmypdf`, `imagemagick`,
`ffmpeg`, and the `smbclient` PHP extension (for external storage / `files_external`
SMB mounts) baked in. `default_phone_region` is preset to `AT`.

## Image

```
ghcr.io/welworx/nextcloud-ocr-smb:latest
ghcr.io/welworx/nextcloud-ocr-smb:stable-apache
ghcr.io/welworx/nextcloud-ocr-smb:<nextcloud-version>-apache   # e.g. 28.0.1-apache
```

Tags mirror the upstream `nextcloud` image's own tagging scheme (version-apache /
stable-apache / latest). GitHub Actions rebuilds and re-tags daily, so `latest` and
`stable-apache` always track the current upstream `nextcloud:stable-apache` image;
`<version>-apache` tags accumulate one per Nextcloud release actually built.

## Usage

Drop-in replacement for `nextcloud:stable-apache` in your `docker-compose.yml`:

```yaml
services:
  app:
    image: ghcr.io/welworx/nextcloud-ocr-smb:stable-apache
    # ... same volumes/env as the official image
```

## One-time setup

GHCR packages are private by default even in a public repo. After the first
Actions run publishes the image, set the package visibility to public in
GitHub: repo → Packages → `nextcloud-ocr-smb` → Package settings → Change
visibility.
