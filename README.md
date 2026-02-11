# Project Management API (Go + SQLite)

一个基于 **Go + Chi + SQLite** 实现的轻量级项目管理 RESTful API。

支持：

-   ✅ 项目（Projects）CRUD
-   ✅ 任务（Tasks）CRUD
-   ✅ 条件筛选 + 分页 + 排序
-   ✅ 外键级联删除
-   ✅ 自动建表
-   ✅ 跨域支持（CORS 全开放）
-   ✅ 零依赖数据库（SQLite 本地文件）

------------------------------------------------------------------------

# 📦 技术栈

-   Go
-   Chi Router
-   SQLite (modernc.org/sqlite)
-   RESTful API
-   JSON

------------------------------------------------------------------------

# 🚀 快速开始

## 1️⃣ 下载项目

``` bash
git clone <your-repo-url>
cd <project-folder>
```

或者直接下载 zip 解压。

------------------------------------------------------------------------

## 2️⃣ 初始化 Go Module

如果你还没有 `go.mod`：

``` bash
go mod init project-api
go mod tidy
```

------------------------------------------------------------------------

## 3️⃣ 运行项目

``` bash
go run main.go
```

默认监听：

    http://localhost:8080

启动日志：

    Project API listening on :8080 (db=pm.db)

数据库文件会自动生成：

    pm.db

------------------------------------------------------------------------

# ⚙️ 环境变量

  变量      说明                              默认值
  --------- --------------------------------- --------
  DB_PATH   SQLite 数据库路径                 pm.db
  PORT      监听端口                          8080
  ADDR      完整监听地址（优先级高于 PORT）   \-

示例：

``` bash
export DB_PATH=data.db
export PORT=9000
go run main.go
```

------------------------------------------------------------------------

# 🧪 测试接口命令

## Health Check

``` bash
curl http://localhost:8080/health
```

------------------------------------------------------------------------

# 📁 Projects API

## 创建项目

``` bash
curl -X POST http://localhost:8080/projects   -H "Content-Type: application/json"   -d '{
    "name": "Website Redesign",
    "description": "Frontend + Backend upgrade",
    "budget": 50000,
    "status": "active"
}'
```

## 查询项目列表

``` bash
curl "http://localhost:8080/projects?limit=10&offset=0"
```

支持筛选：

    ?status=active
    ?project_manager_id=1
    ?client_id=2
    ?q=web
    ?sort=deadline asc

## 查询单个项目

``` bash
curl http://localhost:8080/projects/1
```

## 更新项目

``` bash
curl -X PUT http://localhost:8080/projects/1   -H "Content-Type: application/json"   -d '{
    "name": "Website V2",
    "status": "active"
}'
```

## 修改项目状态

``` bash
curl -X PATCH http://localhost:8080/projects/1/status   -H "Content-Type: application/json"   -d '{"status":"completed"}'
```

## 删除项目

``` bash
curl -X DELETE http://localhost:8080/projects/1
```

⚠ 删除项目会级联删除其下所有任务。

------------------------------------------------------------------------

# ✅ Tasks API

## 创建任务（顶级）

``` bash
curl -X POST http://localhost:8080/tasks   -H "Content-Type: application/json"   -d '{
    "sqlproject_id": 1,
    "task_name": "Design UI",
    "priority": "high",
    "status": "todo"
}'
```

## 在项目下创建任务

``` bash
curl -X POST http://localhost:8080/projects/1/tasks   -H "Content-Type: application/json"   -d '{
    "task_name": "Build Backend",
    "priority": "urgent"
}'
```

## 查询任务列表

``` bash
curl "http://localhost:8080/tasks?status=todo&limit=10"
```

支持筛选：

    ?sqlproject_id=1
    ?status=doing
    ?assignee_id=2
    ?priority=high
    ?due_before=2026-12-31
    ?q=design
    ?sort=due_date asc

## 查询单个任务

``` bash
curl http://localhost:8080/tasks/1
```

## 更新任务

``` bash
curl -X PUT http://localhost:8080/tasks/1   -H "Content-Type: application/json"   -d '{
    "sqlproject_id": 1,
    "task_name": "Design UI v2",
    "status": "doing"
}'
```

## 修改任务状态

``` bash
curl -X PATCH http://localhost:8080/tasks/1/status   -H "Content-Type: application/json"   -d '{"status":"done"}'
```

## 删除任务

``` bash
curl -X DELETE http://localhost:8080/tasks/1
```

------------------------------------------------------------------------

# 📊 数据结构示例

## Project

``` json
{
  "sqlid": 1,
  "name": "Website Redesign",
  "status": "active",
  "created_at": "2026-02-11T10:00:00Z"
}
```

## Task

``` json
{
  "sqlid": 1,
  "sqlproject_id": 1,
  "task_name": "Design UI",
  "status": "todo",
  "created_at": "2026-02-11T10:05:00Z"
}
```

------------------------------------------------------------------------

# 🌍 部署说明

兼容：

-   Railway
-   Render
-   Koyeb
-   Fly.io
-   VPS

确保设置：

    PORT 环境变量

------------------------------------------------------------------------

# 📄 License

MIT
