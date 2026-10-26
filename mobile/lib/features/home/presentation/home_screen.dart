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
            Container(
              width: 44,
              height: 44,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.asset(
                'assets/demo/aps/logo-aps.png',
                fit: BoxFit.contain,
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
                    'APS demo • ${l.goodMorning}',
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
          SectionHeader(
            title: l.nearbyServices,
            action: l.viewAll,
            onAction: () => context.go('/map'),
          ),
          const SizedBox(height: 12),
          _NearbyCard(
            title: l.findAtm,
            secondary: l.findPos,
            action: l.manualSearch,
          ),
          const SizedBox(height: 26),
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
          const SizedBox(height: 26),
          SectionHeader(
            title: l.learn,
            action: l.viewAll,
            onAction: () => context.go('/explore'),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 190,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _CampaignCard(
                  asset: 'assets/demo/aps/secure-payment.jpg',
                  title: l.securityTips,
                ),
                _CampaignCard(
                  asset: 'assets/demo/aps/bank-cards.jpg',
                  title: l.digitalPayments,
                ),
                _CampaignCard(
                  asset: 'assets/demo/aps/POS.jpg',
                  title: l.merchantServices,
                ),
              ],
            ),
          ),
          const SizedBox(height: 26),
          SectionHeader(title: l.announcements),
          const SizedBox(height: 12),
          _NoticeCard(title: l.independentDisclaimer),
          const SizedBox(height: 18),
          SampleDataBanner(text: l.sampleData),
        ],
      ),
    );
  }
}

class _NearbyCard extends StatelessWidget {
  const _NearbyCard({
    required this.title,
    required this.secondary,
    required this.action,
  });
  final String title, secondary, action;

  @override
  Widget build(BuildContext context) => Card(
    clipBehavior: Clip.antiAlias,
    child: InkWell(
      onTap: () => context.go('/map'),
      child: SizedBox(
        height: 142,
        child: Stack(
          children: [
            PositionedDirectional(
              end: -24,
              top: -38,
              child: Icon(
                Icons.public_rounded,
                size: 180,
                color: Theme.of(context).colorScheme.primary
                    .withValues(alpha: .07),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _MapPin(icon: Icons.local_atm_rounded),
                      const SizedBox(width: 8),
                      _MapPin(icon: Icons.point_of_sale_rounded),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    '$title  •  $secondary',
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(
                        Icons.search_rounded,
                        size: 17,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        action,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Spacer(),
                      const Icon(Icons.arrow_forward_rounded, size: 19),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class _MapPin extends StatelessWidget {
  const _MapPin({required this.icon});
  final IconData icon;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(9),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.primary,
      borderRadius: BorderRadius.circular(13),
    ),
    child: Icon(icon, color: Theme.of(context).colorScheme.onPrimary, size: 20),
  );
}

class _CampaignCard extends StatelessWidget {
  const _CampaignCard({required this.asset, required this.title});
  final String asset;
  final String title;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsetsDirectional.only(end: 12),
    child: SizedBox(
      width: 250,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => context.go('/explore'),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(asset, fit: BoxFit.cover),
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Color(0xD9082B3A)],
                  ),
                ),
              ),
              PositionedDirectional(
                start: 16,
                end: 16,
                bottom: 14,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class _NoticeCard extends StatelessWidget {
  const _NoticeCard({required this.title});
  final String title;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.surface,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: Theme.of(context).colorScheme.outlineVariant
            .withValues(alpha: .5),
      ),
    ),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFF3B33D).withValues(alpha: .16),
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Icon(Icons.campaign_outlined, color: Color(0xFF9A6700)),
        ),
        const SizedBox(width: 13),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w700, height: 1.35),
          ),
        ),
        const Icon(Icons.chevron_right_rounded),
      ],
    ),
  );
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
