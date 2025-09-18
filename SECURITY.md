# Security & Compliance Guidelines – Expensy

This document outlines the security and compliance measures implemented for the **Expensy – End-to-End DevOps Deployment** project.

---

## 🔑 Secrets & Credential Management
- **GitHub Actions**:  
  All sensitive values (e.g., `NEXT_PUBLIC_API_URL`, database connection strings, Redis password) are stored as **GitHub Secrets**.  
  They are never committed into version control.
  
- **Kubernetes Secrets**:  
  Backend credentials (MongoDB URI, Redis password) are injected into pods using **Kubernetes Secrets** in the `expensy` namespace.

- **ConfigMaps**:  
  Non-sensitive environment variables (e.g., API URLs, service configs) are stored in ConfigMaps.

---

## 🔐 Access & Identity
- **Azure AKS Authentication**:  
  Access to the AKS cluster is restricted to authorized users via Azure AD + `az aks get-credentials`.  
  No root credentials are used in pipelines.

- **IAM Roles / RBAC**:  
  Kubernetes RBAC ensures separation of privileges.  
  Service accounts are scoped per namespace where possible.

---

## 🌐 Network Security
- **Security Groups / NSGs**:  
  Only required inbound ports are open:
  - `80`/`443` for web access
  - Cluster internal communication is limited to private networking.

- **Ingress**:  
  At present, frontend/backend are exposed with LoadBalancer services.  
  Planned improvement: migrate to NGINX ingress with enforced **TLS**.

---

## 🔒 Data Security
- **Databases**:  
  - MongoDB and Redis deployed as Kubernetes services.  
  - Default ports are internal to the cluster (not exposed to the internet).  
  - Authentication enabled via secrets.

- **Encryption**:  
  - Azure provides encryption at rest for disks.  
  - TLS termination is planned but not yet fully implemented.

---

## 📊 Monitoring & Logging
- **Monitoring**:  
  - **Prometheus** scrapes metrics from application pods.  
  - **Grafana** dashboards visualize pod health, CPU/memory, and app metrics (e.g., expenses recorded).

- **Logging**:  
  - Application logs accessible via `kubectl logs`.  
  - Future extension: integrate with Azure Monitor or Loki stack.

---

## 📜 Compliance Notes
- **GDPR**:  
  The application stores expense data (user-generated content).  
  Under EU GDPR, this data is protected:
  - Stored in MongoDB (encrypted at rest by Azure).  
  - Not shared with third parties.  
  - Data can be deleted by dropping the DB.

- **Retention**:  
  - Metrics: short-term retention in Prometheus.  
  - Logs: ephemeral unless stored externally (planned for Azure Monitor/Loki).

---

## ✅ Summary of Security Posture
- ✔️ Secrets managed via GitHub & Kubernetes Secrets  
- ✔️ RBAC and namespace isolation in Kubernetes  
- ✔️ Network restricted via NSGs and ClusterIP services  
- ✔️ Monitoring and logging in place  
- ❌ TLS not yet completed (planned)  
- ❌ Centralized long-term logging retention pending

---

_Last updated: September 2025_
