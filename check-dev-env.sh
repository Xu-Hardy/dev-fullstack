#!/bin/bash
set -e

echo "🧪 Checking development environment..."

# 标准工具
echo -n "✅ curl: " && curl --version | head -n 1
echo -n "✅ wget: " && wget --version | head -n 1
echo -n "✅ git: " && git --version
echo -n "✅ vim: " && vim --version | head -n 1

# Conda / Python / Data science
echo -n "🐍 conda: " && conda --version
echo -n "🐍 mamba: " && mamba --version
echo -n "🐍 python: " && python --version
echo -n "🐍 pip: " && pip --version
echo -n "📊 numpy: " && python -c "import numpy; print(numpy.__version__)"
echo -n "📈 pandas: " && python -c "import pandas; print(pandas.__version__)"
echo -n "📉 matplotlib: " && python -c "import matplotlib; print(matplotlib.__version__)"
echo -n "📊 seaborn: " && python -c "import seaborn; print(seaborn.__version__)"
echo -n "🤖 scikit-learn: " && python -c "import sklearn; print(sklearn.__version__)"

# Node.js / 前端工具
echo -n "🟩 node: " && node -v
echo -n "🟩 npm: " && npm -v
echo -n "🛠 yarn: " && yarn -v
echo -n "🛠 pnpm: " && pnpm -v
echo -n "⚡ vite: " && vite --version
echo -n "🔧 vue-cli: " && vue --version

# JupyterLab
echo -n "📓 jupyterlab: " && jupyter lab --version

# Go / Java / C++
echo -n "🐹 go: " && go version
echo -n "☕ javac: " && javac -version
echo -n "☕ java: " && java -version 2>&1 | head -n 1
echo -n "🛠 gcc: " && gcc --version | head -n 1
echo -n "🛠 g++: " && g++ --version | head -n 1

# Docker CLI
echo -n "🐳 docker: " && docker --version
echo -n "🐳 docker-compose: " && docker compose version

# SSH / XRDP
echo -n "📡 sshd: " && ssh -V 2>&1 | head -n 1
echo -n "🖥 xrdp: " && xrdp -v || echo "❌ xrdp not found"

echo "✅ All checks completed."
