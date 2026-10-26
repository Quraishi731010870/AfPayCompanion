import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/common.dart';
import '../../../l10n/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final actions = [
      (Icons.account_balance, l.findBank, 'banks'),
      (Icons.local_atm, l.findAtm, 'atms'),
      (Icons.point_of_sale, l.findPos, 'pos'),
      (Icons.storefront, l.findAgent, 'agents'),
      (Icons.support_agent, l.paymentHelp, 'help'),
      (Icons.description_outlined, l.disputeHelp, 'help'),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(9),
              child: Image.asset(
                'assets/branding/afpay_companion_mark.png',
                width: 36,
                height: 36,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                l.appName,
                style: const TextStyle(fontWeight: FontWeight.w800),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_outlined),
            tooltip: l.notifications,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Text(
            l.goodMorning,
            style: Theme.of(context).textTheme.headlineMedium
                ?.copyWith(fontWeight: FontWeight.w800),
          ),
          Text(
            l.welcomeMessage,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 22),
          SearchEntry(hint: l.searchHint, onTap: () => context.push('/search')),
          const SizedBox(height: 24),
          SectionHeader(title: l.quickActions),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 190,
              mainAxisExtent: 112,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: actions.length,
            itemBuilder: (_, i) => _ActionCard(action: actions[i]),
          ),
          const SizedBox(height: 24),
          Card(
            color: Theme.of(context).colorScheme.primaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.support_agent, size: 36),
                  const SizedBox(height: 12),
                  Text(
                    l.havingProblem,
                    style: Theme.of(context).textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 6),
                  Text(l.problemBody),
                  const SizedBox(height: 14),
                  FilledButton.tonal(
                    onPressed: () => context.go('/help'),
                    child: Text(l.getHelp),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          SectionHeader(
            title: l.nearbyServices,
            action: l.viewAll,
            onAction: () => context.go('/map'),
          ),
          InfoState(
            icon: Icons.location_searching,
            title: l.mapComingSoon,
            body: l.mapComingSoonBody,
            action: l.manualSearch,
            onAction: () => context.push('/search'),
          ),
          SampleDataBanner(text: l.sampleData),
        ],
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({required this.action});
  final (IconData, String, String) action;
  @override
  Widget build(BuildContext context) => Card(
    child: InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () => action.$3 == 'help'
          ? context.go('/help')
          : context.push('/directory/${action.$3}'),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(action.$1, color: Theme.of(context).colorScheme.primary),
            const Spacer(),
            Text(
              action.$2,
              maxLines: 2,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    ),
  );
}
