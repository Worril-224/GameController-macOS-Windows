# macOS 使用说明 — GameController v7.0.0-rc.3

官方 macOS 构建（Universal 二进制，Apple Silicon 与 Intel 均可原生运行，系统要求 macOS ≥ 12.6）。

## 安装

1. 下载 `GameController-7.0.0-rc.3.dmg`（本目录），双击挂载。
2. 把 `GameController.app` 拖进「应用程序」文件夹。
3. 首次启动：聚焦搜索（⌘ + 空格）输入 `GameController` 回车，或到「启动台 / 应用程序」双击图标。

> 如果提示「无法验证开发者 / 无法打开」：**右键点 App → 打开**；或在终端执行：
>
> ```bash
> xattr -cr /Applications/GameController.app
> ```
>
> 该 App 官方未做 Apple 公证（无开发者签名），属正常现象，不影响功能。

## 网络

第一次开始比赛收发网络包时，macOS 可能弹窗「是否允许 GameController 接受传入的网络连接」，
请点 **允许**，否则机器人与监视器无法通信。

通信端口（与 Linux/Windows 版本一致）：

- 发送控制消息：UDP 广播 **3838**，2 Hz（停止比赛时短时 5 Hz）
- 接收机器人状态消息：UDP 单播 **3939**
- 接收队伍消息：UDP 广播 **10000 + 队号**
- 监视器接口：**3636** 请求，3838 返回真实状态，**3940** 转发状态消息

## 日志

```
~/Library/Application Support/GameController/logs
```

## 配置

配置文件位于 App 包内：

```
/Applications/GameController.app/Contents/config/
```

结构与 Linux 版 `config/` 完全一样（`teams.yaml` + 各赛制 `params.yaml` / `teams.yaml`），修改后重启生效。
若修改后启动提示签名问题，执行一次本地 ad-hoc 签名即可：

```bash
codesign --force --deep --sign - /Applications/GameController.app
```

## 校验

```
260fdd092d9dc7ae280e447a12018a7d4c474fa22c823b458797788601267a08  GameController-7.0.0-rc.3.dmg
```

（与官方 Release 公布值一致）

## 来源

- 上游项目：<https://github.com/RoboCup-HumanoidSoccerLeague/GameController>
- 发行版本：<https://github.com/RoboCup-HumanoidSoccerLeague/GameController/releases/tag/v7.0.0-rc.3>
- 许可证：MIT
