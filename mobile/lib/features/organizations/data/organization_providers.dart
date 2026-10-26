import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/organization.dart';
import 'mock_organization_repository.dart';

final organizationRepositoryProvider = Provider<OrganizationRepository>(
  (ref) => MockOrganizationRepository(),
);
final organizationsProvider =
    FutureProvider.family<List<Organization>, OrganizationType?>(
      (ref, type) => ref
          .watch(organizationRepositoryProvider)
          .getOrganizations(type: type),
    );
final organizationProvider = FutureProvider.family<Organization?, String>(
  (ref, id) => ref.watch(organizationRepositoryProvider).getById(id),
);

class SearchQueryNotifier extends Notifier<String> {
  @override
  String build() => '';
  void update(String value) => state = value;
}

final searchQueryProvider = NotifierProvider<SearchQueryNotifier, String>(
  SearchQueryNotifier.new,
);
final searchResultsProvider = FutureProvider<List<Organization>>(
  (ref) => ref
      .watch(organizationRepositoryProvider)
      .getOrganizations(query: ref.watch(searchQueryProvider)),
);
