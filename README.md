# Yoshunko
# ![title](assets/img/title.png)

**Yoshunko** 是游戏 **《JQL》** 的服务器模拟器。其主要目标是提供丰富的功能和定制能力，同时保持代码库简洁。**Yoshunko** 除了 Zig 标准库外，不使用任何第三方依赖。

## 快速开始
### 环境要求
- [Zig 0.16.0-dev.1364](https://ziglang.org/builds/zig-x86_64-linux-0.16.0-dev.1364+f0a3df98d.tar.xz)
- [SDK 服务器](https://git.xeondev.com/reversedrooms/hoyo-sdk/releases)

##### 注意：此服务器不包含 SDK 服务器，因为它并非针对单个游戏。你可以将此服务器与 `hoyo-sdk` 配合使用。
<!-- ##### 注意 2：此服务器仅适用于真实操作系统，例如 GNU/Linux。如果你没有此类系统，可以使用 `WSL`。 -->

#### 如需额外帮助，可以加入我们的 [Discord 服务器](https://discord.xeondev.com)
### 安装配置
#### 从源码构建
```sh
git clone https://git.xeondev.com/yoshunko/yoshunko.git
cd yoshunko
zig build run-dpsv &
zig build run-gamesv
```

### 配置说明
**Yoshunko** 没有特定的配置文件，但其行为可以通过另一种方式修改。用户需要操作服务器的 `state` 目录。例如，`dpsv` 向客户端提供的区域列表定义在 `state/gateway` 目录下。另一个例子是玩家数据：每个玩家的状态以文件系统形式表示，位于 `state/player/[UID]` 目录下。state 文件可以随时编辑，服务器会立即应用这些更改。当你向玩家 state 目录下的文件写入内容时，服务器会热重载该文件并与客户端同步状态。

### 登录游戏
当前支持的客户端版本为 `CNBetaWin2.5.2`，你可以从第三方渠道获取。接下来，你需要应用必要的[客户端补丁](https://git.xeondev.com/yidhari-zs/Tentacle)。它允许你连接到本地服务器，并将加密密钥替换为自定义密钥。

## 社区交流
- [我们的 Discord 服务器](https://discord.xeondev.com)
- [我们的 Telegram 频道](https://t.me/reversedrooms)

## 捐赠支持
持续产出开源软件需要时间、代码的贡献，尤其是分发方面更需要资金支持。如果你能贡献力量，这将有助于确保我们能够继续编写、支持和托管让所有人生活更便利的高质量软件。欢迎通过 [Boosty](https://boosty.to/xeondev/donate) 进行捐赠！