import '../domain/organization.dart';

class MockOrganizationRepository implements OrganizationRepository {
  static final _items = [
    Organization(
      id: 'demo-bank-one',
      name: 'Demo Aman Bank',
      shortName: 'DABK',
      type: OrganizationType.bank,
      description: 'Development-only sample profile demonstrating bank directory content and digital service discovery.',
      services: ['ATM access', 'Card services', 'Mobile banking'],
      city: 'Kabul',
      address: 'Sample address, Shahr-e-Naw',
      phone: '+93 000 000 000',
      website: 'https://example.com',
      source: 'Development sample record',
      sourceUrl: 'https://example.com',
      lastVerified: DateTime(2026, 1, 15),
      status: VerificationStatus.pending,
    ),
    Organization(
      id: 'demo-bank-two',
      name: 'Sample Horizon Bank',
      shortName: 'SHB',
      type: OrganizationType.bank,
      description: 'Fictional development data used to validate responsive directory and search experiences.',
      services: ['Branch banking', 'Transfers', 'Merchant services'],
      city: 'Herat',
      address: 'Sample address, Central Herat',
      phone: '+93 000 000 001',
      website: 'https://example.com',
      source: 'Development sample record',
      sourceUrl: 'https://example.com',
      lastVerified: DateTime(2026, 1, 10),
      status: VerificationStatus.pending,
    ),
    Organization(
      id: 'demo-emi-one',
      name: 'DemoPay Wallet',
      shortName: 'DPW',
      type: OrganizationType.emi,
      description: 'Fictional EMI profile for interface development. It is not an operational service listing.',
      services: ['Mobile wallet', 'Agent cash-in', 'Bill information'],
      city: 'Kabul',
      address: 'Sample digital service',
      phone: '+93 000 000 002',
      website: 'https://example.com',
      source: 'Development sample record',
      sourceUrl: 'https://example.com',
      lastVerified: DateTime(2026, 1, 8),
      status: VerificationStatus.pending,
    ),
    Organization(
      id: 'demo-pi-one',
      name: 'Sample Payment Services',
      shortName: 'SPS',
      type: OrganizationType.paymentInstitution,
      description: 'Fictional payment institution record used solely for software development.',
      services: ['Merchant acquiring', 'QR education', 'Payment support'],
      city: 'Mazar-e-Sharif',
      address: 'Sample address',
      phone: '+93 000 000 003',
      website: 'https://example.com',
      source: 'Development sample record',
      sourceUrl: 'https://example.com',
      lastVerified: DateTime(2026, 1, 5),
      status: VerificationStatus.pending,
    ),
  ];
  @override
  Future<List<Organization>> getOrganizations({
    OrganizationType? type,
    String query = '',
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 220));
    final q = query.trim().toLowerCase();
    return _items
        .where(
          (x) =>
              (type == null || x.type == type) &&
              (q.isEmpty ||
                  x.name.toLowerCase().contains(q) ||
                  x.city.toLowerCase().contains(q) ||
                  x.services.any((s) => s.toLowerCase().contains(q))),
        )
        .toList();
  }

  @override
  Future<Organization?> getById(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 120));
    for (final item in _items) {
      if (item.id == id) return item;
    }
    return null;
  }
}
