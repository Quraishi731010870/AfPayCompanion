# Architecture

The repository is a phased monorepo. The Flutter client uses feature-first modules with presentation, domain, and data separation for complex features. Riverpod owns application state and dependency injection; GoRouter owns navigation. External data is accessed only through repository interfaces, allowing mock, REST, cache, and future approved integrations to be swapped without rewriting UI.

Phase 3 adds a `LocationRepository` and replaceable `MapProvider` interface. Phase 6 adds a `NotificationGateway`. Phase 7 provides FastAPI service/repository layers backed by PostgreSQL and Redis. The React admin consumes the same versioned REST contract.

Data freshness is part of the domain model rather than a display-only field. UI must never infer real-time availability from an old verification record.
