# job-tracker-app-infrastructure

Infrastructure configuration for the Job Tracker application. Contains Docker Compose for local development, Kubernetes manifests for production deployment, and CI/CD pipeline templates.

## Local development

Starts all services, PostgreSQL, Kafka, MinIO, and dependencies with a single command:

```bash
docker-compose up -d
```

### Service ports (local)

| Service                  | Port  |
|--------------------------|-------|
| API Gateway              | 5000  |
| Job Service              | 5001  |
| Contact Service          | 5002  |
| Journal Service          | 5003  |
| Resume Service           | 5004  |
| Notification Service     | 5005  |
| AI Service               | 5006  |
| User Service             | 5007  |
| PostgreSQL               | 5432  |
| Kafka                    | 9092  |
| MinIO (blob storage)     | 9000  |
| MinIO Console            | 9001  |

## Kubernetes

Manifests are organized per service under `k8s/`. Each service has a Deployment, Service, and ConfigMap.

```bash
kubectl apply -f k8s/namespace.yml
kubectl apply -f k8s/
```

## Structure

```
docker-compose.yml       # Full local dev stack
k8s/
  namespace.yml
  gateway/
  job-service/
  contact-service/
  journal-service/
  resume-service/
  notification-service/
  ai-service/
  user-service/
  postgres/
  kafka/
  minio/
scripts/
  seed-db.sh            # Seed demo account data
  reset-demo.sh         # Reset demo account to baseline
```
