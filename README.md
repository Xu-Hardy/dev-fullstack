# 🐳 dev-fullstack：跨平台多语言开发环境镜像

这是一个高度集成、跨架构（x86_64 + arm64）通用的开发者工作环境镜像，预装多种主流开发语言与工具链，适用于本地开发容器、CI 构建、远程桌面开发、数据科学任务等多场景。

---

## 🚀 特性概览

| 分类        | 内容                                                                 |
|-------------|----------------------------------------------------------------------|
| 系统        | Ubuntu 22.04 + SSH + XFCE 图形界面 + XRDP                           |
| Python      | Miniforge + Conda + mamba + 常用数据科学工具包                      |
| Node.js     | Node.js 20 + npm + yarn + pnpm + @vue/cli + Vite                    |
| 前端支持    | 支持 Vue/Vite 前端项目初始化与开发调试                              |
| JupyterLab  | 默认开启、支持密码登录，自动挂载工作目录                             |
| Java        | OpenJDK 17（Java 开发）                                             |
| Go          | Go 1.21（支持多平台交叉编译）                                       |
| C/C++       | gcc + g++ + build-essential                                          |
| Docker CLI  | docker + docker-compose plugin                                      |
| 多架构构建  | 支持 `amd64` 与 `arm64`，基于 `buildx` 一键构建多平台镜像           |
| VSCode 支持 | 预设 DevContainer，配套开发插件自动安装                              |

---

## 📦 镜像信息

- 镜像名称：`cloudsmithy/dev-fullstack`
- 支持架构：`linux/amd64`, `linux/arm64`
- 默认工作目录：`/workspace`
- 默认用户：`root`
- 启动服务：
  - SSH：密码 `devpass`
  - RDP：XRDP 桌面访问 `3389`
  - JupyterLab：监听 `8888`，密码为 `1234.com`

---

## 🧰 包含工具和语言环境

### ✅ Python & Data Science

- Python 解释器：来自 Miniforge（conda-forge）
- 包管理器：`conda`, `mamba`, `pip`
- 数据科学常用包：

```bash
numpy pandas matplotlib seaborn scikit-learn scipy
plotly sympy tqdm ipykernel jupyterlab notebook
```

---

### ✅ Node.js & 前端生态

- Node.js v20.x
- 全局工具：`npm`, `yarn`, `pnpm`, `@vue/cli`, `vite`

---

### ✅ Java, Go, C/C++

- OpenJDK 17
- Go 1.21（支持 ARM 架构）
- GCC / G++ / 编译链工具

---

### ✅ Docker CLI + Compose

支持在容器中运行 `docker` 和 `docker compose` 命令（需宿主机挂载 socket）

---

## 🖥️ 远程图形访问（XRDP）

容器中集成 XFCE 桌面环境 + XRDP 远程桌面协议，适用于图形界面开发、调试、使用 JupyterLab with GUI。

访问方式（默认端口 `3389`）：

```bash
RDP 客户端连接 localhost:3389
用户名：root
密码：devpass
```

---

## 🔐 JupyterLab 默认开启

容器启动后自动运行：

```bash
jupyter lab --config=/root/.jupyter/jupyter_lab_config.py
```

默认密码：`1234.com`  
监听地址：`http://localhost:8888`

---

## 📂 挂载本地项目目录

使用 `docker run` 或 `docker-compose` 挂载：

```yaml
volumes:
  - ./workspace:/workspace
```

---

## 🧪 自检脚本（可选）

容器中内置 `/check-dev-env.sh`，可用于一键检查环境是否安装完整：

```bash
bash /check-dev-env.sh
```

---

## ✅ 快速启动（Docker Compose）

```yaml
version: "3.8"

services:
  dev-fullstack:
    image: cloudsmithy/dev-fullstack:latest
    container_name: dev-fullstack
    ports:
      - "2222:22"
      - "3389:3389"
      - "8888:8888"
    volumes:
      - ./workspace:/workspace
    restart: unless-stopped
    privileged: true
```

---

## 🔧 开发推荐配套

- 使用 VSCode DevContainer 自动加载 `.devcontainer/devcontainer.json`
- 推荐搭配远程开发插件（Remote Containers）
- 可用于部署 CI 编译机、教学机、AI Notebook Server 等

---

## 🧑‍💻 作者 & License

Maintainer: `yourname@example.com`  
License: MIT