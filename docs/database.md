# Database design

PostgreSQL is planned for Phase 7 with UUID primary keys, normalized organizations and locations, foreign keys, targeted indexes, timestamps, and soft deletion for managed content. Location records carry source, source URL, verification status, verified date, notes, and last update. Audit events are append-only and exclude credentials.

Alembic migrations will define users, admin users, RBAC, organizations, service/location entities, knowledge content, announcements, notification topics, feedback, favorites, search history, and audit logs. Schema code will be introduced with the backend rather than duplicated as an untested placeholder.
