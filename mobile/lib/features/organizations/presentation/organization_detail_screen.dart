import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/state/app_settings.dart';
import '../../../core/widgets/common.dart';
import '../../../l10n/app_localizations.dart';
import '../data/organization_providers.dart';

class OrganizationDetailScreen extends ConsumerWidget {
  const OrganizationDetailScreen({super.key, required this.id});
  final String id;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context),
        value = ref.watch(organizationProvider(id)),
        favorites = ref.watch(favoritesProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(l.directory),
        actions: [
          IconButton(
            onPressed: () => ref.read(favoritesProvider.notifier).toggle(id),
            icon: Icon(
              favorites.contains(id) ? Icons.favorite : Icons.favorite_border,
            ),
            tooltip: l.favorites,
          ),
        ],
      ),
      body: value.when(
        loading: () =>
            const Padding(padding: EdgeInsets.all(18), child: SkeletonCard()),
        error: (_, _) => InfoState(
          icon: Icons.error_outline,
          title: l.somethingWrong,
          body: l.noResultsBody,
        ),
        data: (o) {
          if (o == null) {
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
              const SizedBox(height: 18),
              Center(
                child: Container(
                  width: 84,
                  height: 84,
                  padding: EdgeInsets.all(o.imageAsset == null ? 0 : 10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: o.imageAsset == null
                      ? Center(
                          child: Text(
                            o.shortName,
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 18,
                            ),
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: Image.asset(
                            o.imageAsset!,
                            fit: BoxFit.contain,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 14),
              Text(
                o.name,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall
                    ?.copyWith(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 10),
              Center(
                child: VerificationBadge(
                  label: o.isVerified ? l.verified : l.pendingVerification,
                  verified: o.isVerified,
                ),
              ),
              const SizedBox(height: 22),
              Text(
                o.description,
                style: Theme.of(context).textTheme.bodyLarge
                    ?.copyWith(height: 1.55),
              ),
              const SizedBox(height: 24),
              _section(
                context,
                l.services,
                o.services
                    .map(
                      (s) => ListTile(
                        leading: const Icon(Icons.check_circle_outline),
                        title: Text(s),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 14),
              _section(context, l.contact, [
                ListTile(
                  leading: const Icon(Icons.location_on_outlined),
                  title: Text(o.address),
                  subtitle: Text(o.city),
                ),
                ListTile(
                  leading: const Icon(Icons.phone_outlined),
                  title: Text(o.phone),
                ),
                ListTile(
                  leading: const Icon(Icons.language),
                  title: Text(o.website),
                ),
              ]),
              const SizedBox(height: 14),
              _section(context, l.officialSource, [
                ListTile(
                  title: Text(o.source),
                  subtitle: Text(
                    '${l.lastVerified}: ${o.lastVerified.toIso8601String().split('T').first}',
                  ),
                ),
              ]),
              const SizedBox(height: 18),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.flag_outlined),
                label: Text(l.reportIncorrect),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _section(BuildContext context, String title, List<Widget> children) =>
      Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.w800),
                ),
              ),
              ...children,
            ],
          ),
        ),
      );
}
