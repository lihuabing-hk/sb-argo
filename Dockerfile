# 使用 Node 20 更兼容新包
FROM node:20-slim

ENV NODE_ENV=production
ENV PORT=55036

WORKDIR /app

# 安装编译依赖
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    python3 \
    g++ \
    make \
    ca-certificates \
 && rm -rf /var/lib/apt/lists/*

# 复制 package.json 和 package-lock.json
COPY package*.json ./

# 使用国内镜像加速并安装依赖
RUN npm config set registry https://registry.npmmirror.com/ \
    && npm install --only=production

# 复制项目文件
COPY . .

# 确保脚本可执行
RUN chmod +x whm.sh || true

EXPOSE 8080

CMD ["sh", "-c", "PORT=${PORT:-8080} node app.js"]
