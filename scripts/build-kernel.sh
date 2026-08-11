#!/bin/bash
set -euo pipefail

DEFCONFIG="${DEFCONFIG:-vendor/kona-perf_defconfig}"
OUTDIR="${OUTDIR:-out}"

export ARCH="${ARCH:-arm64}"

echo "=== Build Configuration ==="
echo "  ARCH:      ${ARCH}"
echo "  DEFCONFIG: ${DEFCONFIG}"
echo "  OUTDIR:    ${OUTDIR}"
echo "  LLVM:      1"
echo "  CCACHE:    $(which ccache 2>/dev/null || echo 'not found')"
echo "  clang:     $(clang --version 2>/dev/null | head -1 || echo 'not found')"
echo "==========================="

mkdir -p "${OUTDIR}"

MAKE_FLAGS=(
  "LLVM=1"
  "ARCH=${ARCH}"
  "O=${OUTDIR}"
)

make "${MAKE_FLAGS[@]}" ${DEFCONFIG}

make "${MAKE_FLAGS[@]}" -j"$(nproc)" 2>&1 | tee "${OUTDIR}/build.log"

echo "=== Build Complete ==="
ls -lh "${OUTDIR}"/arch/arm64/boot/Image* "${OUTDIR}"/arch/arm64/boot/dtbo.img 2>/dev/null || echo "Some artifacts missing"
