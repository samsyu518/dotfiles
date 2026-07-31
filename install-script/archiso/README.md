# archiso: Arch live ISO with debootstrap

A custom Arch Linux live ISO that can install **both Arch and Debian**, built so
that nothing has to be downloaded into the live environment at install time.

## Why

The stock Arch ISO goes stale. Installing anything into it with `pacman -Sy`
pulls newer dependencies against an old base (partial upgrade), and the live
root is a 256 MB cowspace, which is a hard ceiling rather than a tight fit.
Baking `debootstrap` into the image sidesteps both.

`debian-archive-keyring` is in Arch's `extra` repo, so Debian's release
signatures are verified normally -- no `--no-check-gpg`.

## Layout

| File | Purpose |
|---|---|
| `build.sh` | Stages the releng profile, applies the delta, runs `mkarchiso` |
| `packages.extra` | Packages appended to `packages.x86_64` |
| `overlay/` | Merged into `airootfs/` |

The upstream `releng` profile is **not vendored**. `build.sh` copies it from the
installed `archiso` package at build time, so it always tracks upstream and only
the delta lives in this repo.

## Build

Locally:

```bash
sudo pacman -S archiso
sudo ./install-script/archiso/build.sh    # ISO lands in ./out
```

`WORK` and `OUT` are overridable; the work dir needs roughly 10-15 GB and must
not be on a small tmpfs.

In CI: `.github/workflows/build-iso.yml` builds inside a privileged
`archlinux:latest` container and publishes the ISO plus `SHA256SUMS` as a GitHub
release. It runs on `workflow_dispatch` and monthly. Because the repo is public,
**nothing secret may be added to `overlay/`** -- the ISO is world-downloadable.

## Adding your own install script

Drop it in `overlay/usr/local/bin/`. `build.sh` detects files there and injects
the matching `file_permissions` entry into `profiledef.sh`, so it arrives on the
ISO as `0:0:755`. Without that entry archiso copies it non-executable.

## Field note

The firmware on some machines rebuilds its NVRAM on every boot and discards
OS-created entries, which presents as "GRUB never appears" on an install that is
otherwise completely intact. After `grub-install`, check with `efibootmgr` that
the entry survived; the durable workaround is to also place shim at
`\EFI\Microsoft\Boot\bootmgfw.efi`, which the firmware's own generic HDD entry
will find without NVRAM.
