# Use Python 3.9 base image
FROM python:3.9-slim

# Install tools and Wine
RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
    wine64 wine32 \
    wget \
    ca-certificates \
    gcc \
    libssl-dev \
    libffi-dev \
    python3-dev \
    mingw-w64 \
    p7zip-full \
    tk-dev \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy project files
COPY . /app

# pypi mirrors
RUN mkdir -p /root/.pip/
RUN echo "[global]" > /root/.pip/pip.conf
RUN echo "index-url = https://pypi.tuna.tsinghua.edu.cn/simple" >> /root/.pip/pip.conf
RUN echo "trusted-host = pypi.tuna.tsinghua.edu.cn" >> /root/.pip/pip.conf

RUN pip install --upgrade pip setuptools wheel

# Install PyInstaller
RUN pip install pyinstaller

RUN pip install .

# Run PyInstaller to package using .spec file
RUN pyinstaller main.spec
