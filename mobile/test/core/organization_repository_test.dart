import 'package:afpay_companion/features/organizations/data/mock_organization_repository.dart';
import 'package:afpay_companion/features/organizations/domain/organization.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final repository = MockOrganizationRepository();

  test('filters organizations by type', () async {
    final banks = await repository.getOrganizations(
      type: OrganizationType.bank,
    );
    expect(banks, isNotEmpty);
    expect(banks.every((item) => item.type == OrganizationType.bank), isTrue);
  });

  test('searches names, cities and services', () async {
    expect(await repository.getOrganizations(query: 'HesabPay'), hasLength(1));
    expect(await repository.getOrganizations(query: 'Kabul'), isNotEmpty);
    expect(await repository.getOrganizations(query: 'digital'), isNotEmpty);
  });
}
