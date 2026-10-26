# Deployment

Development, staging, and production remain isolated. Phase 7 will add Docker images for FastAPI, PostgreSQL, and Redis plus migrations and health checks. Phase 8 adds the admin image. Production release requires managed secrets, TLS termination, database backups, monitoring, log retention, vulnerability scanning, rollback instructions, and explicit approval; CI does not auto-deploy.
