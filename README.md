# GameController v7.0.0-rc.3 — macOS / Windows 可运行版

[RoboCup Humanoid Soccer League](https://github.com/RoboCup-HumanoidSoccerLeague) 官方比赛控制软件 **GameController v7.0.0-rc.3** 的 macOS 与 Windows **现成可运行包**。

本仓库是官方发行版的**整理与再分发**：所有二进制均下载自官方 GitHub Release，并用官方公布的 SHA-256 校验（见下文），**未修改任何程序内容**。

- 上游项目：<https://github.com/RoboCup-HumanoidSoccerLeague/GameController>
- 对应版本：<https://github.com/RoboCup-HumanoidSoccerLeague/GameController/releases/tag/v7.0.0-rc.3>
- 许可证：MIT（见 [LICENSE](LICENSE)，版权归 Arne Hasselbring 及贡献者）

> English: Unofficial ready-to-run packages of the official RoboCup HSL **GameController v7.0.0-rc.3** builds —
> macOS Universal (12.6+, Apple Silicon & Intel) and Windows x64. Binaries are unmodified official artifacts,
> verified by SHA-256. License: MIT, © Arne Hasselbring and contributors. See usage notes below.

---

## 下载（GitHub Release）

不想 clone 仓库的话，可以直接下载现成安装包：

👉 **<https://github.com/Worril-224/GameController-macOS-Windows/releases/tag/v7.0.0-rc.3>**

- macOS：`GameController-7.0.0-rc.3.dmg`（Universal，macOS 12.6+）
- Windows：`GameController-7.0.0-rc.3-x86_64-pc-windows-msvc.zip`（x64）
- 校验：`SHA256SUMS.txt`

## 快速开始

### Windows 10 / 11 (x64)

1. 下载 / clone 本仓库，进入目录：
   `windows/GameController-7.0.0-rc.3-x86_64-pc-windows-msvc/`
2. 双击 **`GameController.bat`**（或直接运行 `target/release/game_controller_app.exe`）。
3. 如出现 SmartScreen 提示「Windows 已保护你的电脑」：点 **更多信息 → 仍要运行**。
4. 第一次开始比赛收发网络包时，Windows 防火墙会询问，请点 **允许**
   （否则机器人、监视器收不到数据）。

> ⚠️ exe 依赖同级的 `config/` 目录（程序按相对路径读取 `../../config`），请**整目录使用**，不要只单独拷走 exe。

### macOS 12.6+（Apple Silicon / Intel 通用）

1. 下载 `macos/GameController-7.0.0-rc.3.dmg` 并双击挂载。
2. 把其中的 `GameController.app` 拖进「应用程序」。
3. 首次打开若提示「无法验证开发者」：**右键点 App → 打开**；或在终端执行
   ```bash
   xattr -cr /Applications/GameController.app
   ```
4. 详见 [macOS 使用说明](macos/README-macOS.md)。

---

## 功能（与官方版本一致）

同一份源码、同一版本号的官方构建，功能完全相同：

- **启动器**：赛制（small / middle / large × foundation / advanced）、双方队伍、球衣颜色、开球方、
  镜像、全屏、网卡、Broadcast / Multicast、No Delay、Penalty Shoot-out。
- **主界面**：计时计分、罚时（含 Motion in Set / Pick-up 等特殊罚时）、换人与改门将、暂停/恢复（空格键）、
  加时（+1 分钟）、中场休息、加时赛、点球大战、消息计数与超限判罚、撤销时间线等。
- **网络通信**（与机器人 / 监视器交互，协议与官方一致）：
  - 发送控制消息：UDP 广播 **3838**，2 Hz（停止比赛时短时 5 Hz）
  - 接收机器人状态消息：UDP 单播 **3939**
  - 接收队伍消息：UDP 广播 **10000 + 队号**（每队一条，最大 512 字节）
  - 监视器接口：**3636** 请求，3838 返回真实状态，**3940** 转发状态消息
- **日志**：
  - Windows：程序目录下的 `logs/`
  - macOS：`~/Library/Application Support/GameController/logs`

---

## 目录结构

```
.
├── LICENSE                     # MIT 许可证（上游）
├── README.md                   # 本文件
├── SHA256SUMS.txt              # 本仓库内文件的 SHA-256
├── windows/
│   ├── README-Windows.md       # Windows 使用说明（中文）
│   └── GameController-7.0.0-rc.3-x86_64-pc-windows-msvc/
│       ├── GameController.bat              # 双击启动
│       ├── config/                         # 赛制参数与队伍名单
│       └── target/release/game_controller_app.exe
├── macos/
│   ├── README-macOS.md         # macOS 使用说明（中文）
│   └── GameController-7.0.0-rc.3.dmg       # 官方 macOS 安装镜像（Universal）
└── scripts/
    └── download-official-release.sh        # 重新下载并校验官方发行包
```

---

## 完整性校验

官方 Release 公布的 SHA-256（本仓库对应文件与之一致）：

| 文件 | SHA-256 |
| --- | --- |
| `GameController-7.0.0-rc.3.dmg`（macOS，本仓库 `macos/`） | `260fdd092d9dc7ae280e447a12018a7d4c474fa22c823b458797788601267a08` |
| `GameController-7.0.0-rc.3-x86_64-pc-windows-msvc.zip`（Windows 官方压缩包） | `f8bf2e2b07bb607af5fa1c4f19b66767722dec5b6f5a3549400fafae5fe80670` |
| `game_controller-7.0.0-rc.3-x86_64-unknown-linux-gnu.tar.bz2`（Linux，参考） | `569b63e6a6299dba07c42ad6f19b8effc02e6c5537f1f55975d4abaac94df0d9` |

校验本仓库内文件：

```bash
shasum -a 256 -c SHA256SUMS.txt      # macOS
sha256sum -c SHA256SUMS.txt          # Linux
```

或使用 `scripts/download-official-release.sh` 直接从官方 Release 下载并校验。

---

## 自定义队伍与赛制参数

配置文件是纯 YAML，格式与上游完全一致：

- **Windows**：`windows/GameController-7.0.0-rc.3-x86_64-pc-windows-msvc/config/`
- **macOS**：`/Applications/GameController.app/Contents/config/`

```
config/
├── teams.yaml              # 全局队伍名单（队号、队名、可用球衣颜色）
├── small_foundation/       # 各赛制：params.yaml（参数）+ teams.yaml（参赛队号）
├── ...（共 6 个赛制目录）
```

修改后重启程序生效。macOS 版修改后若遇到签名问题，可执行：

```bash
codesign --force --deep --sign - /Applications/GameController.app
```

---

## 说明 / 免责声明

- 本仓库仅对官方二进制做**整理与再分发**，便于在 macOS / Windows 上一键使用；程序本身版权归原作者所有（MIT）。
- macOS 官方包未经 Apple 公证，首次运行需右键「打开」或清除隔离属性，属正常现象。
- Windows exe 为官方 MSVC x64 构建，无法在 macOS/Linux 上直接运行（需 Windows 或虚拟机）。
- 需要自行编译或参与开发，请前往上游仓库：<https://github.com/RoboCup-HumanoidSoccerLeague/GameController>
