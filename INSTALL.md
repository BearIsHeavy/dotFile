# Ubuntu 24.04 初始化操作手册

## 前置条件

- 全新 Ubuntu 24.04 系统（桌面版或 Server 版均可）
- 用户拥有 `sudo` 权限
- 网络连接正常

---

## 快速开始

```bash
# 1. 安装 Git（全新系统可能未预装）
sudo apt update && sudo apt install -y git

# 2. Clone 仓库（必须克隆到 ~/.dotfile）
cd ~
git clone <你的仓库URL> .dotfile
cd .dotfile

# 3. 运行主入口脚本
bash main.sh
```

---

## 主菜单说明

运行 `bash main.sh` 后会显示交互式菜单：

```
========================================
  Dotfiles Setup
  OS: Ubuntu 24.04 LTS
========================================

Please select an option:
  1) Full setup (recommended)
  2) Install packages only
  3) Create symlinks only
  4) Setup individual modules
  5) Exit
```

### 选项说明

| 选项 | 功能 | 适用场景 |
|------|------|---------|
| **1) Full setup** | 一键完成所有安装和配置 | 全新系统首次使用 |
| **2) Install packages only** | 仅安装系统包 | 只想安装软件包 |
| **3) Create symlinks only** | 仅创建配置文件符号链接 | 包已安装，只需链接配置 |
| **4) Setup individual modules** | 手动选择单个模块安装 | 部分功能按需安装 |
| **5) Exit** | 退出脚本 | 不执行任何操作 |

---

## Full Setup 详细流程

选择 **1** 后，脚本会按顺序执行以下步骤：

### Step 1: 安装系统包

运行 `scripts/requirements/ubuntu.sh`，安装的包包括：

| 类别 | 包名 |
|------|------|
| **版本控制** | `git` |
| **网络工具** | `curl`, `wget`, `httpie`, `net-tools` |
| **编辑器** | `vim`, `neovim` |
| **终端工具** | `tmux`, `zsh` |
| **编译工具** | `build-essential`, `gcc`, `g++`, `make`, `cmake` |
| **Python/Node** | `python3`, `python3-pip`, `nodejs`, `npm` |
| **搜索/浏览** | `ripgrep`, `fd-find`, `fzf`, `eza`, `bat`, `tree` |
| **其他** | `jq`, `htop`, `tldr`, `openssh-client`, `openssh-server` |

### Step 2: 创建符号链接

将以下配置文件链接到 `~`：

| 源文件 | 目标链接 |
|--------|---------|
| `.zsh/` | `~/.zsh/` |
| `generalConfig/.profile` | `~/.profile` |
| `generalConfig/.bashrc` | `~/.bashrc` |
| `generalConfig/.vimrc` | `~/.vimrc` |
| `generalConfig/.tmux.conf` | `~/.tmux.conf` |
| `zshconfig/.zshrc` | `~/.zshrc` |
| `zshconfig/.zshenv` | `~/.zshenv` |
| `zshconfig/.zlogin` | `~/.zlogin` |
| `bin/` | `~/bin/` |

如果目标位置已有文件或目录，脚本会先备份为 `.bak`。

### Step 3: 初始化模块

依次自动运行以下模块：

| 模块 | 脚本 | 功能 |
|------|------|------|
| **Zsh** | `scripts/init/zsh.sh` | 安装 zsh、zsh-autosuggestions、提示是否设为默认 shell |
| **Vim** | `scripts/init/vim.sh` | 安装 vim-plug 插件管理器 |
| **Neovim** | `scripts/init/nvim.sh` | 下载最新 Neovim 二进制，创建 `~/.config/nvim` 链接 |
| **Tools** | `scripts/init/tools.sh` | 安装 tmux、shellcheck、eza、tealdeer(tldr) |
| **Fonts** | `scripts/init/fonts.sh` | 下载并安装 0xProto Nerd Font |

### Step 4: 可选模块询问

模块安装完成后，会依次询问：

```
VPN/Clash is optional. Install now? (y/N):
UV (Python package manager) — install now? (y/N):
```

- **VPN** — 安装 clash-for-linux（按需选择，默认不安装）
- **UV** — 安装 Astral uv Python 包管理器（按需选择，默认不安装）

---

## 手动安装单个模块

选择 **4** 后，可单独安装以下模块：

| 编号 | 模块 | 脚本路径 |
|------|------|---------|
| 1 | VPN | `scripts/init/vpn.sh` |
| 2 | Zsh | `scripts/init/zsh.sh` |
| 3 | Vim | `scripts/init/vim.sh` |
| 4 | Neovim | `scripts/init/nvim.sh` |
| 5 | Tools | `scripts/init/tools.sh` |
| 6 | Fonts | `scripts/init/fonts.sh` |
| 7 | Conda | `scripts/init/conda.sh` |
| 8 | Neovide | `scripts/init/neovide.sh` |
| 9 | UV | `scripts/init/uv.sh` |

---

## 初始化完成后的操作

### 1. 重新加载 Shell 配置

```bash
source ~/.zshrc
```

或者直接退出当前终端重新登录。

### 2. Neovim 插件安装

首次启动 Neovim：

```bash
nvim
```

`packer.nvim` 会自动克隆并安装。等待完成后，在 Neovim 命令模式执行：

```
:PackerSync
```

此命令会安装所有在 `plugins-setup.lua` 中声明的插件。

### 3. Vim 插件安装（如需要）

```bash
vim +PlugInstall +qall
```

### 4. Tmux 配置生效

```bash
tmux source-file ~/.tmux.conf
```

---

## 注意事项

### ⚠️ 仓库路径要求

仓库 **必须** 克隆到 `~/.dotfile`。

`.bashrc` 中读取 `.alias` 的路径硬编码为 `$HOME/.dotfile/generalConfig/.alias`。如果克隆到其他位置，别名将无法加载。

### ⚠️ Conda 配置

`.bashrc` 中的 conda 初始化块已被注释（原路径硬编码为 `/home/bear/anaconda3`）。在新机器上需要手动运行：

```bash
conda init bash
conda init zsh
```

### ⚠️ 代理脚本

`setProxy` 别名依赖 `~/bin/enableProxy` 脚本，该脚本不在仓库中。如需使用代理，请自行创建。

### ⚠️ Anaconda 版本

`scripts/init/conda.sh` 中硬编码了 `Anaconda3-2024.10-1`。如果该版本已从 Anaconda 存档中移除，安装会因 SHA256 校验失败而失败。建议直接从 [Anaconda 官网](https://www.anaconda.com/download) 下载最新版本手动安装。

### ⚠️ tealdeer (tldr)

`tools.sh` 使用 `cargo install tealdeer` 替代了破损的 apt `tldr` 包。需要系统上已安装 Rust/cargo。如果没有 cargo，会跳过安装并提示手动安装方法。

### ⚠️ setProxy 别名

`~/.alias` 中的 `setProxy` 依赖 `~/bin/enableProxy` 脚本。该脚本不在仓库中，需要用户自行创建。

---

## 目录结构

```
.dotfile/
├── main.sh                     # 统一入口（运行此文件）
├── INSTALL.md                  # 本操作手册
├── README.md                   # 项目说明
│
├── scripts/
│   ├── bootstrap/              # 全新系统引导脚本
│   │   └── ubuntu.sh           # 系统初始化（镜像/NVIDIA/防火墙）
│   ├── requirements/           # 包依赖
│   │   └── ubuntu.sh           # apt 安装列表
│   └── init/                   # 模块初始化
│       ├── vpn.sh              # VPN/Clash
│       ├── zsh.sh              # Zsh + 自动补全
│       ├── vim.sh              # Vim + vim-plug
│       ├── nvim.sh             # Neovim 二进制 + 配置
│       ├── tools.sh            # tmux, eza, shellcheck 等
│       ├── fonts.sh            # Nerd Font 下载
│       ├── conda.sh            # Anaconda 安装
│       ├── neovide.sh          # Neovide 依赖
│       ├── uv.sh               # UV Python 包管理器
│       └── colors.sh           # 颜色变量（被其他脚本引用）
│
├── generalConfig/              # 通用配置
│   ├── .alias                  # Shell 别名
│   ├── .bashrc
│   ├── .profile
│   ├── .tmux.conf
│   └── .vimrc
│
├── zshconfig/                  # Zsh 配置
│   ├── .zshrc
│   ├── .zshenv
│   ├── .zlogin
│   └── trigger.sh              # Prompt 触发器
│
├── nvim/                       # Neovim 配置
│   ├── init.lua
│   ├── coc-settings.json
│   ├── lua/
│   └── plugin/
│
├── bin/                        # 自定义脚本
├── vscode_config/              # VS Code 配置
└── .gitignore
```

---

## 故障排除

### 符号链接创建失败

- 确保从 `.dotfile` 目录运行 `bash main.sh`
- 检查 `~` 下是否已有同名文件（脚本会自动备份为 `.bak`）

### 包安装失败

```bash
sudo apt update
```

然后重新运行 `bash main.sh`。

### Neovim 插件安装失败

- 确保网络连接正常
- 如果在国内，可能需要先配置代理：`bash scripts/init/vpn.sh`
- 在 Neovim 中运行 `:checkhealth` 查看健康状态

### 字体显示异常

- 确保终端已安装并配置了 Nerd Font（如 0xProto Nerd Font）
- 在终端设置中将字体切换为已安装的 Nerd Font

### Zsh 自动补全不工作

- 确认 `~/.zsh/zsh-autosuggestions/` 目录存在
- 如果不存在，手动克隆：
  ```bash
  git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
  ```
