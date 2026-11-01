#!/usr/bin/env bash
# 从官方 GitHub Release 下载 GameController v7.0.0-rc.3 的 macOS / Windows 发行包，
# 并用官方公布的 SHA-256 校验后解压。
#
# 用法:
#   ./scripts/download-official-release.sh            # 下载到 ./official-release/
#   ./scripts/download-official-release.sh /tmp/gc    # 下载到指定目录
#
# 依赖: curl、unzip，以及 shasum（macOS）或 sha256sum（Linux）。
set -euo pipefail

VERSION="v7.0.0-rc.3"
BASE="https://github.com/RoboCup-HumanoidSoccerLeague/GameController/releases/download/${VERSION}"
OUT="${1:-official-release}"

MACOS_DMG="GameController-7.0.0-rc.3.dmg"
WINDOWS_ZIP="GameController-7.0.0-rc.3-x86_64-pc-windows-msvc.zip"

SHA_DMG="260fdd092d9dc7ae280e447a12018a7d4c474fa22c823b458797788601267a08"
SHA_ZIP="f8bf2e2b07bb607af5fa1c4f19b66767722dec5b6f5a3549400fafae5fe80670"

# 选择可用的 SHA-256 校验命令
if command -v sha256sum >/dev/null 2>&1; then
  sha256() { sha256sum "$1" | awk '{print $1}'; }
elif command -v shasum >/dev/null 2>&1; then
  sha256() { shasum -a 256 "$1" | awk '{print $1}'; }
else
  echo "错误: 未找到 sha256sum 或 shasum" >&2
  exit 1
fi

verify() {
  local file="$1" expected="$2" actual
  actual="$(sha256 "$file")"
  if [ "$actual" = "$expected" ]; then
    echo "  ✔ SHA-256 校验通过: $(basename "$file")"
  else
    echo "  ✘ SHA-256 不匹配: $(basename "$file")" >&2
    echo "    期望: $expected" >&2
    echo "    实际: $actual" >&2
    exit 1
  fi
}

mkdir -p "$OUT"
cd "$OUT"

echo "==> 下载 macOS 安装镜像 ..."
curl -fL --retry 5 --retry-delay 2 -C - -o "$MACOS_DMG" "$BASE/$MACOS_DMG"
verify "$MACOS_DMG" "$SHA_DMG"

echo "==> 下载 Windows 发行包 ..."
curl -fL --retry 5 --retry-delay 2 -C - -o "$WINDOWS_ZIP" "$BASE/$WINDOWS_ZIP"
verify "$WINDOWS_ZIP" "$SHA_ZIP"

echo "==> 解压 Windows 发行包 ..."
unzip -o -q "$WINDOWS_ZIP"

echo
echo "完成: $(pwd)"
echo "  - $MACOS_DMG                     # 双击挂载后拖入「应用程序」"
echo "  - ${WINDOWS_ZIP%.zip}/            # 目录内双击 GameController.bat 运行"
