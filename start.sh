#!/bin/bash
set -e

echo "🚀 Starting SSH, XRDP, and JupyterLab..."

# 启动 SSH
service ssh start

# 启动 XRDP
service xrdp start

# 显式定义 conda 路径
CONDA_PYTHON=/opt/conda/bin/python
JUPYTER_CONFIG=/root/.jupyter/jupyter_lab_config.py

# 如果配置文件不存在则生成
if [ ! -f "$JUPYTER_CONFIG" ]; then
    echo "🔧 Generating Jupyter config..."
    /opt/conda/bin/jupyter lab --generate-config
fi

# 如果密码没写入，则写入
if ! grep -q "c.ServerApp.password" "$JUPYTER_CONFIG"; then
    echo "🔐 Generating Jupyter password..."
    HASHED=$($CONDA_PYTHON -c "from notebook.auth import passwd; print(passwd('1234.com'))")
    echo "c.ServerApp.password = u'$HASHED'" >> "$JUPYTER_CONFIG"
    echo "c.ServerApp.ip = '0.0.0.0'" >> "$JUPYTER_CONFIG"
    echo "c.ServerApp.port = 8888" >> "$JUPYTER_CONFIG"
    echo "c.ServerApp.open_browser = False" >> "$JUPYTER_CONFIG"
    echo "c.ServerApp.allow_root = True" >> "$JUPYTER_CONFIG"
fi

# 启动 JupyterLab
echo "📣 JupyterLab running at http://localhost:8888 (password: 1234.com)"
jupyter lab --config="$JUPYTER_CONFIG"
