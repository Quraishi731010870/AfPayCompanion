import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/common.dart';
import '../../../l10n/app_localizations.dart';
import '../../organizations/data/organization_providers.dart';
import '../../organizations/presentation/directory_screen.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});
  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  late final TextEditingController controller;
  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context),
        results = ref.watch(searchResultsProvider);
    return Scaffold(
      appBar: AppBar(title: Text(l.search)),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            TextField(
              controller: controller,
              autofocus: true,
              textInputAction: TextInputAction.search,
              onChanged: (v) =>
                  ref.read(searchQueryProvider.notifier).update(v),
              decoration: InputDecoration(
                hintText: l.searchHint,
                prefixIcon: const Icon(Icons.search),
                suffixIcon: controller.text.isEmpty
                    ? null
                    : IconButton(
                        onPressed: () {
                          controller.clear();
                          ref.read(searchQueryProvider.notifier).update('');
                          setState(() {});
                        },
                        icon: const Icon(Icons.close),
                      ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: results.when(
                loading: () => const Column(
                  children: [
                    SkeletonCard(),
                    SizedBox(height: 12),
                    SkeletonCard(),
                  ],
                ),
                error: (_, _) => InfoState(
                  icon: Icons.cloud_off,
                  title: l.somethingWrong,
                  body: l.noResultsBody,
                ),
                data: (items) => items.isEmpty
                    ? InfoState(
                        icon: Icons.search_off,
                        title: l.noResults,
                        body: l.noResultsBody,
                      )
                    : ListView(
                        children: [
                          SampleDataBanner(text: l.sampleData),
                          const SizedBox(height: 14),
                          ...items.map(
                            (o) => Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: OrganizationCard(
                                item: o,
                                onTap: () =>
                                    context.push('/organization/${o.id}'),
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
