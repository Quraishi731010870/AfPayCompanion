enum OrganizationType { bank, emi, paymentInstitution }

enum VerificationStatus { verified, pending, communityReported, outdated }

class Organization {
  const Organization({
    required this.id,
    required this.name,
    required this.shortName,
    required this.type,
    required this.description,
    required this.services,
    required this.city,
    required this.address,
    required this.phone,
    required this.website,
    required this.source,
    required this.sourceUrl,
    required this.lastVerified,
    required this.status,
  });
  final String id,
      name,
      shortName,
      description,
      city,
      address,
      phone,
      website,
      source,
      sourceUrl;
  final OrganizationType type;
  final List<String> services;
  final DateTime lastVerified;
  final VerificationStatus status;
  bool get isVerified => status == VerificationStatus.verified;
}

abstract interface class OrganizationRepository {
  Future<List<Organization>> getOrganizations({
    OrganizationType? type,
    String query = '',
  });
  Future<Organization?> getById(String id);
}
