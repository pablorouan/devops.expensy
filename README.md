# 💸 Expensy – End-to-End DevOps Project

Expensy is a full-stack **expense tracker app** built with **Next.js (frontend)** and **Node/Express (backend)**, backed by **MongoDB** and **Redis**.  
This project demonstrates a complete **DevOps lifecycle**: containerization, CI/CD, orchestration on Azure AKS, monitoring, and security practices.

---

## 🚀 Project Overview

- **Frontend**: Next.js application (React-based UI).
- **Backend**: Node/Express API.
- **Database**: MongoDB for expense data.
- **Cache**: Redis for fast lookups.
- **Deployment**: Azure Kubernetes Service (AKS).
- **CI/CD**: GitHub Actions pipeline for build → test → Docker build → push → deploy.
- **Monitoring**: Prometheus & Grafana dashboards for pod health + custom app metrics.

---

## 🛠️ Local Development

### Prerequisites
- Node.js 20+
- Docker Desktop
- MongoDB & Redis containers

### Start Databases
```bash
# MongoDB
docker run --name mongo -d -p 27017:27017   -e MONGO_INITDB_ROOT_USERNAME=root   -e MONGO_INITDB_ROOT_PASSWORD=example   mongo:latest

# Redis
docker run --name redis -d -p 6379:6379   redis:latest redis-server --requirepass someredispassword
```

### Backend
```bash
cd expensy_backend
npm ci
npm run dev
```

### Frontend
```bash
cd expensy_frontend
npm ci
NEXT_PUBLIC_API_URL=http://localhost:8706 npm run dev
```

App will be available at **http://localhost:3000**

---

## 🐳 Containerization

Each service has its own Dockerfile:

- `expensy_backend/Dockerfile`
- `expensy_frontend/Dockerfile`

### Build & Run Locally
```bash
docker build -t prouan/expensy-backend ./expensy_backend
docker build -t prouan/expensy-frontend ./expensy_frontend

docker-compose up
```

(Optional) `docker-compose.yaml` helps run backend + frontend + DBs.

---

## ⚙️ CI/CD Pipeline

CI/CD workflow is defined in  
`.github/workflows/ci-cd.yaml`

Stages:
1. **Build & Test** (frontend & backend)  
2. **Docker Build & Push** to Docker Hub (`prouan/expensy-*`)  
3. **Deploy to AKS** (namespace: `expensy`) using `kubectl apply`  

Secrets in GitHub Actions:
- `NEXT_PUBLIC_API_URL`
- `KUBECONFIG`
- `DOCKERHUB_USERNAME`
- `DOCKERHUB_TOKEN`

---

## ☸️ Kubernetes Deployment (AKS)

Manifests located in `k8s/`:
- `backend.yaml`
- `frontend.yaml`

Apply manifests:
```bash
kubectl apply -f k8s/backend.yaml -n expensy
kubectl apply -f k8s/frontend.yaml -n expensy
```

Services:
- Backend: LoadBalancer → `http://<backend-ip>:8706`
- Frontend: LoadBalancer → `http://<frontend-ip>:80`

---

## 📊 Monitoring

Deployed in `monitoring/` namespace:
- **Prometheus** (scrapes pod metrics + app metrics `/metrics` endpoint).  
- **Grafana** (LoadBalancer service, external IP exposed).  

Dashboards:
- Pod health (CPU, memory, restarts).  
- App metrics: total expenses recorded.  

---

## 🔐 Security & Compliance

See [SECURITY.md](./SECURITY.md) for details.

Key points:
- Secrets stored in GitHub Actions + Kubernetes Secrets.  
- RBAC + namespace isolation.  
- NSGs restrict inbound traffic.  
- Data encrypted at rest by Azure.  
- TLS planned but not yet implemented.  

---

## 📂 Repository Structure
```
devops.expensy/
├── expensy_frontend/      # Next.js frontend
├── expensy_backend/       # Node/Express backend
├── k8s/                   # Kubernetes manifests
├── monitoring/            # Prometheus & Grafana configs
├── .github/workflows/     # CI/CD pipeline
├── SECURITY.md
└── README.md
```

---

## 📝 Credits

Developed by **Pablo Rouan**  
Ironhack DevOps Bootcamp – Final Project 2025
