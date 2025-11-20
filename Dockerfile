FROM node:18-slim

ENV NODE_ENV=production
ENV PORT=8080

WORKDIR /app

# 安装系统依赖（build-essential + python3）
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    python3 \
    g++ \
    make \
    ca-certificates \
 && rm -rf /var/lib/apt/lists/*

COPY package*.json ./

RUN npm ci --only=production

COPY . .

RUN chmod +x whm.sh || true

EXPOSE 8080
CMD ["sh", "-c", "PORT=${PORT:-8080} node app.js"]
