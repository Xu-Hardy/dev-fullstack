# syntax=docker/dockerfile:1.4

FROM ubuntu:22.04
LABEL maintainer="yourname@example.com"

ARG TARGETARCH
ENV DEBIAN_FRONTEND=noninteractive
ENV CONDA_DIR=/opt/conda
ENV PATH=$CONDA_DIR/bin:/usr/local/go/bin:$PATH

# 安装系统工具 + SSH + 图形界面 + XRDP
RUN apt-get update && apt-get install -y \
    curl wget git vim unzip build-essential \
    openssh-server xrdp xfce4 xfce4-goodies dbus-x11 x11-xserver-utils \
    ca-certificates gnupg software-properties-common \
    openjdk-17-jdk apt-transport-https lsb-release \
    && echo 'root:devpass' | chpasswd \
    && mkdir /var/run/sshd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && echo xfce4-session >~/.xsession \
    && systemctl enable xrdp \
    && rm -rf /var/lib/apt/lists/*

# 安装 Miniforge（适配 ARM/x86 架构）
RUN case "${TARGETARCH}" in \
      "amd64") ARCH="x86_64" ;; \
      "arm64") ARCH="aarch64" ;; \
      *) echo "Unsupported arch: ${TARGETARCH}" && exit 1 ;; \
    esac && \
    curl -sSLo /tmp/miniforge.sh https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-${ARCH}.sh && \
    bash /tmp/miniforge.sh -b -p $CONDA_DIR && \
    rm /tmp/miniforge.sh && \
    $CONDA_DIR/bin/conda install -y mamba -n base -c conda-forge && \
    $CONDA_DIR/bin/mamba install -y \
        jupyterlab notebook ipykernel \
        numpy pandas matplotlib seaborn scikit-learn scipy \
        sympy plotly tqdm requests pyyaml jinja2 && \
    $CONDA_DIR/bin/conda clean -a -y

# 安装 Node.js v20 + Vue CLI + Vite + yarn/pnpm
RUN apt-get update && apt-get install -y curl wget gnupg lsb-release && \
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g npm@latest && \
    npm install -g yarn pnpm @vue/cli vite

# 安装 Go（适配架构）
ENV GO_VERSION=1.21.5
RUN curl -LO https://golang.org/dl/go${GO_VERSION}.linux-${TARGETARCH}.tar.gz && \
    rm -rf /usr/local/go && \
    tar -C /usr/local -xzf go${GO_VERSION}.linux-${TARGETARCH}.tar.gz && \
    rm go${GO_VERSION}.linux-${TARGETARCH}.tar.gz

# 安装 Docker CLI + Compose 插件
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list && \
    apt-get update && apt-get install -y docker-ce-cli docker-compose-plugin && \
    rm -rf /var/lib/apt/lists/*

# 启动脚本
COPY start.sh /start.sh
RUN chmod +x /start.sh

# 设置默认工作目录
WORKDIR /workspace

# 开放常用端口：SSH (22), XRDP (3389), JupyterLab (8888)
EXPOSE 22 3389 8888

# 默认启动入口
CMD ["/start.sh"]