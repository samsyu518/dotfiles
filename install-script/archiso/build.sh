#!/bin/bash
# Build a custom Arch Linux live ISO with debootstrap baked in, so a single USB
# can install both Arch and Debian without needing network access to pacman
# (which breaks on an ISO whose packages have gone stale against rolling repos).
#
# The releng profile is copied from the installed archiso package at build time
# rather than vendored into this repo, so it always tracks upstream.
#
# Usage:  sudo ./build.sh
# Env:    RELENG=  WORK=  OUT=

set -euo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
RELENG="${RELENG:-/usr/share/archiso/configs/releng}"
WORK="${WORK:-${HERE}/work}"
OUT="${OUT:-${HERE}/out}"
PROFILE="${WORK}/profile"

if [[ ${EUID} -ne 0 ]]; then
    echo "error: must run as root (mkarchiso chroots and mounts)" >&2
    exit 1
fi

if ! command -v mkarchiso >/dev/null; then
    echo "error: mkarchiso not found, install it with: pacman -S archiso" >&2
    exit 1
fi

if [[ ! -d ${RELENG} ]]; then
    echo "error: releng profile not found at ${RELENG}" >&2
    exit 1
fi

echo "==> staging profile from ${RELENG}"
rm -rf "${PROFILE}"
mkdir -p "${PROFILE}" "${OUT}"
cp -a "${RELENG}/." "${PROFILE}/"

echo "==> appending packages.extra"
{
    echo ""
    echo "# --- added by dotfiles/install-script/archiso ---"
    grep -vE '^[[:space:]]*(#|$)' "${HERE}/packages.extra"
} >>"${PROFILE}/packages.x86_64"

if [[ -d ${HERE}/overlay ]]; then
    echo "==> applying airootfs overlay"
    cp -a "${HERE}/overlay/." "${PROFILE}/airootfs/"

    # archiso copies the overlay without preserving an exec bit, so anything
    # dropped into /usr/local/bin has to be declared in file_permissions or it
    # lands on the ISO non-executable.
    # The array is declared as `declare -A file_permissions=(` upstream, so the
    # match must not be anchored to the bare name.
    while IFS= read -r -d '' f; do
        rel="/usr/local/bin/$(basename "${f}")"
        echo "    exec bit: ${rel}"
        sed -i "/file_permissions=($/a\\  [\"${rel}\"]=\"0:0:755\"" \
            "${PROFILE}/profiledef.sh"
        if ! grep -qF "[\"${rel}\"]=\"0:0:755\"" "${PROFILE}/profiledef.sh"; then
            echo "error: failed to inject file_permissions for ${rel};" \
                 "upstream profiledef.sh format changed" >&2
            exit 1
        fi
    done < <(find "${HERE}/overlay/usr/local/bin" -maxdepth 1 -type f \
        -not -name '.*' -print0 2>/dev/null)
fi

echo "==> branding profiledef.sh"
sed -i \
    -e 's|^iso_name=.*|iso_name="archdeb"|' \
    -e 's|^iso_publisher=.*|iso_publisher="samsyu518 <https://github.com/samsyu518/dotfiles>"|' \
    -e 's|^iso_application=.*|iso_application="Arch Linux live + debootstrap"|' \
    "${PROFILE}/profiledef.sh"
# iso_label is deliberately left alone: the bootloader configs reference it
# through %ARCHISO_LABEL% and the live init locates the squashfs by it.

echo "==> mkarchiso"
mkarchiso -v -w "${WORK}/mkarchiso" -o "${OUT}" "${PROFILE}"

echo "==> done"
ls -lh "${OUT}"
