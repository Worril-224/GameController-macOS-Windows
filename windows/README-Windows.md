# Windows 使用说明 — GameController v7.0.0-rc.3

官方 Windows 构建（x86_64 MSVC，Windows 10 / 11 64 位）。

## 运行

1. 进入本目录：`GameController-7.0.0-rc.3-x86_64-pc-windows-msvc/`
2. 双击 **`GameController.bat`**；
   或者直接运行 `target\release\game_controller_app.exe`。
3. 如出现 SmartScreen 提示「Windows 已保护你的电脑」：点 **更多信息 → 仍要运行**。

> ⚠️ **请整目录使用，不要只单独拷贝 exe**。程序按相对路径
> （exe 往上两级）读取 `config/` 目录，缺少配置将无法正常工作。

启动后先出现**启动器窗口**：选择赛制（small / middle / large × foundation / advanced）、
双方队伍、球衣颜色、开球方、镜像、全屏、网卡、Broadcast / Multicast 等，
设置好进入主界面即可开始比赛（操作与原版完全一致）。

## 网络

第一次开始比赛收发网络包时，Windows 防火墙会弹窗询问，请点 **允许**
（专用/公用网络按实际比赛网络选择），否则机器人与监视器无法通信。

通信端口（与 Linux / macOS 版本一致）：

- 发送控制消息：UDP 广播 **3838**，2 Hz（停止比赛时短时 5 Hz）
- 接收机器人状态消息：UDP 单播 **3939**
- 接收队伍消息：UDP 广播 **10000 + 队号**
- 监视器接口：**3636** 请求，3838 返回真实状态，**3940** 转发状态消息

## 日志

程序目录下的 `logs/`：

```
GameController-7.0.0-rc.3-x86_64-pc-windows-msvc\logs\
```

## 配置

```
GameController-7.0.0-rc.3-x86_64-pc-windows-msvc\config\
├── teams.yaml              # 全局队伍名单
└── <赛制>/params.yaml      # 各赛制参数与参赛队号
```

修改后重启程序生效。

## 校验

```
5a9f36b9ae968554d0dcd9264b9ba4a40bc9ecdac7f38b29d517b321a597cbb8  target/release/game_controller_app.exe
f8bf2e2b07bb607af5fa1c4f19b66767722dec5b6f5a3549400fafae5fe80670  GameController-7.0.0-rc.3-x86_64-pc-windows-msvc.zip（官方压缩包）
```

（zip 的 SHA-256 与官方 Release 公布值一致；本目录内容即该 zip 的原样解压。）

## 来源

- 上游项目：<https://github.com/RoboCup-HumanoidSoccerLeague/GameController>
- 发行版本：<https://github.com/RoboCup-HumanoidSoccerLeague/GameController/releases/tag/v7.0.0-rc.3>
- 许可证：MIT
