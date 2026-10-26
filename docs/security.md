# Security and privacy

- Never store PINs, CVVs, OTPs, passwords, banking credentials, or payment authentication secrets.
- Never connect to APS, SmartVista, CBS, HSM, or confidential institutional systems without an authorized public API.
- Secrets belong in environment/secret managers and never in Git.
- Admin authentication requires strong password hashing, short access-token lifetime, refresh rotation, RBAC, rate limiting, audit logging, and secure headers.
- Mobile logs and analytics must exclude financial reference data and personal form content.
- Location and notification permissions are contextual and optional.
- User-facing errors are safe and generic; operational detail stays in structured server logs.
- Dependency and container scanning are required before production deployment.
