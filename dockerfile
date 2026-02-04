# Dockerfile - 放在仓库根目录
FROM golang:1.21-alpine AS builder

# 安装构建 SQLite 需要的工具
RUN apk add --no-cache gcc musl-dev

WORKDIR /app

# 复制依赖文件
COPY go.mod go.sum ./
RUN go mod download

# 复制源代码
COPY . .

# 构建应用（启用 CGO 以支持 SQLite）
ENV CGO_ENABLED=1
RUN go build -o main .

# 运行阶段
FROM alpine:latest

# 安装 SQLite 运行时库
RUN apk add --no-cache sqlite ca-certificates

WORKDIR /app

# 从构建阶段复制二进制文件
COPY --from=builder /app/main .

# 创建数据目录（用于持久化存储）
RUN mkdir -p /data

# 暴露端口
EXPOSE 8080

# 启动应用
CMD ["./main"]
