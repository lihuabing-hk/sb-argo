FROM node:18-slim

ENV NODE_ENV=production

# Hugging Face / Docker 前端统一使用 PORT 环境变量
ENV PORT=8080

WORKDIR /app

# 安装依赖（利用缓存）
COPY package*.json ./
RUN npm ci --only=production

# 拷贝项目文件
COPY . .

# 确保脚本可执行
RUN chmod +x whm.sh || true

EXPOSE 8080

# 关键：兼容 HuggingFace 注入的 PORT 环境变量
CMD ["sh", "-c", "PORT=${PORT:-8080} node app.js"]
