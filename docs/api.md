# API contract

The future API is versioned under `/api/v1` and returns consistent envelopes containing `success`, `data`, `message`, and optional pagination `meta`. Public reads cover organizations, services, locations, FAQs, articles, announcements, and troubleshooting knowledge. Public writes accept feedback, correction reports, optional dispute drafts, and device registrations.

Admin endpoints require short-lived JWT access tokens, refresh-token rotation, and RBAC. Pagination, filtering, sorting, validation, rate limiting, and OpenAPI documentation are mandatory. No internal banking or payment-switch interface may be connected without formal authorization and an approved public contract.
