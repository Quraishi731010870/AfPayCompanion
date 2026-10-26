import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/common.dart';
import '../../../l10n/app_localizations.dart';
import '../data/organization_providers.dart';
import '../domain/organization.dart';

OrganizationType? typeFromPath(String type) => switch (type) {
  'banks' => OrganizationType.bank,
  'emis' => OrganizationType.emi,
  'payment-institutions' => OrganizationType.paymentInstitution,
  _ => null,
};

class DirectoryScreen extends ConsumerWidget {
  const DirectoryScreen({super.key, required this.type});
  final String type;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context), kind = typeFromPath(type);
    final title = switch (kind) {
      OrganizationType.bank => l.banks,
      OrganizationType.emi => l.emis,
      OrganizationType.paymentInstitution => l.paymentInstitutions,
      null => l.directory,
    };
    final value = ref.watch(organizationsProvider(kind));
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: value.when(
        loading: () => ListView(
          padding: const EdgeInsets.all(18),
          children: const [
            SkeletonCard(),
            SizedBox(height: 12),
            SkeletonCard(),
          ],
        ),
        error: (_, _) => InfoState(
          icon: Icons.cloud_off,
          title: l.somethingWrong,
          body: l.noResultsBody,
          action: l.retry,
          onAction: () => ref.invalidate(organizationsProvider(kind)),
        ),
        data: (items) {
          if (items.isEmpty) {
            return InfoState(
              icon: Icons.search_off,
              title: l.noResults,
              body: l.noResultsBody,
            );
          }
          return ListView(
            padding: const EdgeInsets.all(18),
            children: [
              SampleDataBanner(text: l.sampleData),
              const SizedBox(height: 14),
              for (final o in items)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: OrganizationCard(
                    item: o,
                    onTap: () => context.push('/organization/${o.id}'),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class OrganizationCard extends StatelessWidget {
  const OrganizationCard({super.key, required this.item, required this.onTap});
  final Organization item;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final initials = item.shortName.substring(
      0,
      item.shortName.length.clamp(0, 3),
    );
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 26,
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                child: Text(
                  initials,
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: Theme.of(context).textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${item.city} · ${item.services.take(2).join(' · ')}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 9),
                    VerificationBadge(
                      label: item.isVerified
                          ? l.verified
                          : l.pendingVerification,
                      verified: item.isVerified,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}
