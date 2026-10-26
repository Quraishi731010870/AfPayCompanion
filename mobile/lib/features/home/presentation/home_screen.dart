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
        toolbarHeight: 70,
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(9),
              child: Image.asset(
                'assets/branding/afpay_companion_mark.png',
                width: 40,
                height: 40,
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
          Container(
            margin: const EdgeInsetsDirectional.only(end: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_none_rounded),
              tooltip: l.notifications,
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 8, 18, 28),
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(22, 22, 22, 24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF073B47), Color(0xFF087F72)],
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF087F72).withValues(alpha: .22),
                  blurRadius: 28,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: .12),
                    borderRadius: BorderRadius.circular(99),
                  ),
                  child: Text(
                    l.goodMorning,
                    style: const TextStyle(
                      color: Color(0xFFD8FFF8),
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  l.welcomeMessage,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    height: 1.15,
                    letterSpacing: -.4,
                  ),
                ),
                const SizedBox(height: 20),
                SearchEntry(
                  hint: l.searchHint,
                  onTap: () => context.push('/search'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          SectionHeader(title: l.quickActions),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 190,
              mainAxisExtent: 106,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: actions.length,
            itemBuilder: (_, i) => _ActionCard(action: actions[i]),
          ),
          const SizedBox(height: 24),
          Card(
            color: Theme.of(context).colorScheme.secondaryContainer
                .withValues(alpha: .55),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary
                          .withValues(alpha: .14),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      Icons.support_agent_rounded,
                      size: 28,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
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
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(9),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary
                    .withValues(alpha: .10),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                action.$1,
                color: Theme.of(context).colorScheme.primary,
                size: 23,
              ),
            ),
            const Spacer(),
            Text(
              action.$2,
              maxLines: 2,
              style: const TextStyle(fontWeight: FontWeight.w800, height: 1.15),
            ),
          ],
        ),
      ),
    ),
  );
}
