# Yoshunko
# ![标题](assets/img/title.png)

**Yoshunko** 是一款为游戏 **《JQL》** 开发的服务器模拟器。其主要目标是提供丰富的功能和自定义能力，同时保持代码库的简洁性。**Yoshunko** 不使用任何第三方依赖（当然，除了 zig 标准库）。

## 快速开始
### 环境要求
- [Zig 0.16.0-dev.1470](https://ziglang.org/builds/zig-x86_64-linux-0.16.0-dev.1470+32dc46aae.tar.xz)
- [SDK 服务器](https://git.xeondev.com/reversedrooms/hoyo-sdk/releases)
- [Tentacle（客户端补丁）](https://git.xeondev.com/yidhari-zs/Tentacle)
- [KCPShim](https://git.xeondev.com/xeon/kcpshim)

##### 注意：本服务器不包含 SDK 服务器，因为 SDK 并非针对特定游戏。你可以使用 `hoyo-sdk` 与本服务器配合。
<!-- ##### 注意2：本服务器仅可在真实操作系统上运行，例如 GNU/Linux。如果你没有此类系统，可以使用 `WSL`。 -->

#### 如需进一步帮助，可加入我们的 [Discord 服务器](https://discord.xeondev.com)
### 安装配置
#### 从源码构建
```sh
git clone https://git.xeondev.com/yoshunko/yoshunko.git
cd yoshunko
zig build run-dpsv &
zig build run-gamesv
```

### 配置说明
**Yoshunko** 并没有一个专门的配置文件，但其行为可以通过其他方式进行修改。用户可以通过操作服务器的 `state` 目录来实现定制。例如，`dpsv` 向客户端提供服务的区域列表定义在 `state/gateway` 目录下。另一个例子是玩家数据：每个玩家的状态以一个文件系统的形式表示，位于 `state/player/[UID]` 目录中。状态文件可以随时编辑，服务器会立即应用这些更改。当你向玩家状态目录下的文件写入内容时，服务器会热重载该文件并将状态与客户端同步。

### 登录游戏
当前支持的客户端版本为 `CNBetaWin2.6.1`，你可以从第三方来源获取。

接下来，你需要应用必要的[客户端补丁](https://git.xeondev.com/yidhari-zs/Tentacle)。该补丁允许你连接到本地服务器，并将加密密钥替换为自定义密钥。

最后一步，你需要运行 [KCPShim](https://git.xeondev.com/xeon/kcpshim)。它充当中间人，将客户端和服务器之间通过 KCP 发送的数据包转换为 TCP，反之亦然。

## 社区
- [我们的 Discord 服务器](https://discord.xeondev.com)
- [我们的 Telegram 频道](https://t.me/reversedrooms)

## 捐赠支持
持续产出开源软件需要时间、代码的贡献，以及——特别是对于分发环节——资金的支持。如果你有能力进行捐赠，你的贡献将帮助我们继续编写、支持和托管高质量软件，让我们的生活更轻松。欢迎通过 [Boosty](https://boosty.to/xeondev/donate) 进行捐赠！
