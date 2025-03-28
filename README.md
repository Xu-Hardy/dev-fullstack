# 🐳 Dev Fullstack: 跨平台多语言开发环境镜像

一个为开发者量身定制的 Ubuntu + Miniforge 多语言开发环境，支持 x86_64 与 ARM64 架构，集成了：

- 🐍 Python + Conda (Miniforge) + 数据科学工具包
- 🟩 Node.js + Vue CLI + Vite + yarn + pnpm
- ☕ Java (OpenJDK 17)
- 🐹 Go 1.21
- 🔧 C/C++（GCC + G++）
- 📡 OpenSSH 远程访问
- 🖥 图形桌面（XFCE + XRDP）
- 📓 JupyterLab（密码登录 + 浏览器访问）
- 🐳 Docker CLI + Compose 插件

支持使用 Docker Compose 一键部署，默认提供 VSCode DevContainer 支持。

---

## 🚀 快速开始（推荐 Docker Compose）

1. 启动容器：

```bash
docker-compose up -d
```

2. 默认服务端口映射如下：

| 服务       | 端口         | 说明                           |
|------------|--------------|--------------------------------|
| SSH        | `2222`       | 用户名 `root`，密码 `devpass`  |
| RDP 图形桌面 | `3389`     | 支持 Windows/Mac/Linux 客户端 |
| JupyterLab | `8888`       | 密码 `1234.com`，浏览器访问    |

---

## 🗂 工作目录挂载

容器内默认工作目录为 `/workspace`，你可以将本地目录挂载进去：

```yaml
volumes:
  - ./workspace:/workspace
```

---

## 💻 VSCode DevContainer 支持（可选）

项目支持 VSCode Remote Containers，使用前需安装：

- [Remote - Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

默认配置位于 `.devcontainer/devcontainer.json`，启动后自动安装插件：

- Python、Go、Java、C++、Prettier、ESLint、Vue、TailwindCSS、Markdown Preview、Live Server 等

使用步骤：

```bash
F1 → Remote-Containers: Reopen in Container
```

---

## 🧪 验证环境完整性

容器内置环境自检脚本：

```bash
bash /check-dev-env.sh
```

---

## 📦 镜像信息

| 镜像地址 | 架构支持 |
|----------|-----------|
| `cloudsmithy/dev-fullstack:latest` | `amd64` + `arm64`（多平台） |

---

## 🧰 常见用途

- 数据科学与 AI 开发（含 JupyterLab + Conda）
- 前端开发（Vue + React + Vite）
- 多语言项目构建测试（Python/Go/Java/C++）
- VSCode 远程开发容器环境
- 多人远程桌面协作开发（支持 XRDP + SSH）

---

## 📄 License

MIT © Cloudsmithy

