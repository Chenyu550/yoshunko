# Yoshunko
# ![标题](assets/img/title.png)

**Yoshunko** 是一款为游戏 **绝区零** 开发的服务器模拟器。其主要目标是在保持代码库简洁的同时，提供丰富的功能和自定义能力。**Yoshunko** 除 Zig 标准库外，不使用任何第三方依赖。

## 入门指南
### 环境要求
- [Zig 0.16.0-dev.1470](https://ziglang.org/builds/zig-x86_64-linux-0.16.0-dev.1470+32dc46aae.tar.xz)
- [SDK Server](https://git.xeondev.com/reversedrooms/hoyo-sdk/releases)
- [Tentacle (客户端补丁)](https://git.xeondev.com/yidhari-zs/Tentacle)
- [KCPShim](https://git.xeondev.com/xeon/kcpshim)

##### 注意：本服务器不包含 SDK Server，因为它并非针对特定游戏。你可以配合 `hoyo-sdk` 一起使用本服务器。
<!-- ##### 注意 2：本服务器仅能在真正的操作系统上运行，例如 GNU/Linux。如果你没有这样的系统，可以使用 `WSL`。 -->

#### 如需更多帮助，可以加入我们的 [Discord 服务器](https://discord.xeondev.com)
### 安装步骤
#### 从源码构建
```sh
git clone https://git.xeondev.com/yoshunko/yoshunko.git
cd yoshunko
zig build run-dpsv &
zig build run-gamesv
```

### 配置说明
**Yoshunko** 没有特定的配置文件，但其行为可以通过另一种方式进行修改。用户应直接操作服务器的 `state` 目录。例如，`dpsv` 向客户端提供服务的区域列表就定义在 `state/gateway` 目录下。另一个例子是玩家数据：每位玩家的状态都以文件系统的形式呈现，位于 `state/player/[UID]` 目录下。这些状态文件可以随时编辑，服务器会立即应用这些更改。一旦你写入玩家状态目录下的某个文件，服务器就会热加载它，并与客户端同步状态。

### 登录说明
目前支持的客户端版本是 `CNBetaWin2.6.4`，你可以从第三方渠道获取。

接下来，你需要应用必要的 [客户端补丁](https://git.xeondev.com/yidhari-zs/Tentacle)。它允许你连接到本地服务器，并用自定义密钥替换加密密钥。

最后一步，你需要运行 [KCPShim](https://git.xeondev.com/xeon/kcpshim)。它充当中介，负责在客户端和服务器之间将基于 KCP 协议传输的数据包与基于 TCP 协议传输的数据包进行相互转换。

## 社区
- [我们的 Discord 服务器](https://discord.xeondev.com)
- [我们的 Telegram 频道](https://t.me/reversedrooms)

## 捐赠
持续开发开源软件需要时间、代码以及——尤其是对分发来说——资金的投入。如果你能做出贡献，将有助于确保我们能继续编写、维护和托管这些让大家生活更轻松的高质量软件。欢迎通过 [Boosty](https://boosty.to/xeondev/donate) 进行捐赠！