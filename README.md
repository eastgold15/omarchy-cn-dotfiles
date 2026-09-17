# Omarchy Dotfiles

面向公开分享的极简个人配置，适用于 Omarchy 4.x。

Omarchy 掌管桌面默认配置。本仓库只保留有意为之的个人增补：

- Lazygit 工作流定制
- 少量 Yazi 覆盖配置
- Hyprland 个人覆盖配置（入口、显示器、输入、快捷键、自启动、环境变量）
- `omarchy.ime` 输入法插件（以 Git 子模块形式收录）
- 由 mise 管理的可复现全局 CLI 工具集

本仓库有意不替换 Omarchy 的 Neovim、tmux、终端、Git、shell、状态栏、锁屏或生成的主题状态，也不再附带任何自定义主题——主题完全交给 Omarchy 自带的主题系统管理。`config/hypr/` 下的 Lua 文件均为用户自有覆盖：`hyprland.lua` 在加载 Omarchy 默认配置后引入其余覆盖文件，`monitors.lua`、`input.lua`、`bindings.lua`、`autostart.lua`、`envs.lua` 分别对应显示器、输入、快捷键、自启动与环境变量。`./install hypr` 会复制 `config/hypr/` 下的全部 `*.lua` 与 `scripts/` 下的辅助脚本（若存在）。

## 兼容性

已在以下环境测试：

- Omarchy `4.0.0.r1472.g283276b-1`（`edge`）
- Hyprland `0.56.1`
- Lazygit `0.63.1`
- Yazi `26.5.6`

本仓库遵循 Omarchy 的公开 CLI 与用户覆盖边界，绝不写入 `/usr/share/omarchy`。

## 安装

克隆时请连同子模块一起拉取（输入法插件位于子模块中）：

```bash
git clone --recurse-submodules https://github.com/eastgold15/omarchy-ime ./omarchy/plugins/omarchy-ime
```

先检查仓库：

```bash
./check all
./install --dry-run all
```

在全新的 Omarchy 机器上，一次性安装恢复的系统软件包、全局 mise 工具集以及所有非特权配置：

```bash
./install --dry-run bootstrap
./install bootstrap
```

bootstrap 包含从当前机器的 shell 与 pacman 历史中恢复的显式软件包：`cloc`、`cosign`、`minisign` 和 `silicon`。包管理器依赖不单独列出。

安装非特权模块：

```bash
./install all
```

`all` 会安装 Lazygit、Yazi 以及 Hyprland 覆盖配置。

安装可选模块所需的软件包：

```bash
./install packages
```

仅安装全局开发工具：

```bash
./install tools
```

这会将 `~/.config/mise` 链接到本仓库并运行 `mise install`。Bun、Node.js、Go、Java、Codex、Claude、GitHub CLI、uv、pi 和 ast-grep 均使用各自的 mise 后端安装；现有工具选择保持 `latest`，已知需要固定的版本（Node.js、Java）已固定。

## 输入法

输入法配置由 `omarchy.ime` Omarchy 插件掌管，包括 Fcitx5 偏好设置、Rime 方案与词典，以及 Classic UI 主题。该插件独立维护于 [eastgold15/omarchy-ime](https://github.com/eastgold15/omarchy-ime)，在本仓库中以 Git 子模块形式收录于 `omarchy/plugins/omarchy.ime`。本仓库自身仅在 `config/hypr/input.lua` 中保留 Hyprland 左 Shift 切换。

## 私有 Git 身份

将作者身份与签名信息保留在公开仓库之外：

```bash
bin/git-identity
```

交互式设置会以 `0600` 权限写入 `~/.config/git/identity`，并将该文件加入 Git 的全局 include 列表。现有身份数据会备份到 `~/.local/state/dotfiles/backups/` 下。

启用签名时，脚本会复用与 Git 邮箱匹配的密钥。若不存在，则创建带密码保护的 Ed25519 签名密钥，有效期两年，并自动记录其完整指纹。GnuPG 会在交互式终端中询问密码；本仓库既不存储密码，也不存储密钥。

非交互式设置：

```bash
bin/git-identity \
  --name "Your Name" \
  --email "your-private-or-noreply@example.com" \
  --sign
```

使用 `--signing-key "YOUR_OPENPGP_FINGERPRINT"` 显式选择现有密钥，或在不需要提交签名时使用 `--no-sign`。自动创建密钥仍需要交互式终端，以便 GnuPG 请求密码。脚本中不包含任何真实姓名、邮箱地址或密钥指纹。

创建密钥后请单独备份密钥。切勿将私钥导出存储在本仓库中。

以 ASCII 装甲形式打印已配置的公钥：

```bash
bin/git-identity --export-public-key
```

直接复制到 GitHub：

```bash
bin/git-identity --export-public-key | wl-copy
```

此操作仅导出与 Git 所配置指纹关联的公钥。脚本有意不提供私钥导出操作。

## 各独立模块

```bash
./install lazygit
./install yazi
./install hypr
./install tools
./install packages
```

冲突的用户配置会被移动到：

```text
~/.local/state/dotfiles/backups/<timestamp>/
```

## 仓库策略

- 仅安装允许列表中的模块。
- 机器本地与私有数据绝不进入本仓库。
- `~/.local/state/omarchy` 下由 Omarchy 生成的状态绝不被跟踪。
- 不附带自定义主题；主题由 Omarchy 自带的主题系统管理。
