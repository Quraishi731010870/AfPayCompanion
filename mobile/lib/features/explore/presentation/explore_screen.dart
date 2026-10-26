import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/common.dart';
import '../../../l10n/app_localizations.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final groups = [
      (
        l.banking,
        Icons.account_balance,
        [(l.banks, 'banks'), (l.branches, 'branches'), (l.atms, 'atms')],
      ),
      (
        l.digitalPayments,
        Icons.phone_android,
        [
          (l.emis, 'emis'),
          (l.paymentInstitutions, 'payment-institutions'),
          (l.wallets, 'wallets'),
        ],
      ),
      (
        l.merchantServices,
        Icons.storefront,
        [(l.pos, 'pos'), ('QR', 'qr'), (l.agents, 'agents')],
      ),
      (
        l.support,
        Icons.support_agent,
        [(l.troubleshooting, 'help'), (l.disputes, 'help'), (l.faqs, 'help')],
      ),
      (
        l.education,
        Icons.school_outlined,
        [(l.learn, 'learn'), (l.securityTips, 'learn')],
      ),
    ];
    return Scaffold(
      appBar: AppBar(title: Text(l.explore)),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          SearchEntry(hint: l.searchHint, onTap: () => context.push('/search')),
          const SizedBox(height: 18),
          for (final group in groups)
            Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Card(
                child: ExpansionTile(
                  initiallyExpanded: group == groups.first,
                  leading: CircleAvatar(child: Icon(group.$2)),
                  title: Text(
                    group.$1,
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                  children: [
                    for (final item in group.$3)
                      ListTile(
                        title: Text(item.$1),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => item.$2 == 'help'
                            ? context.go('/help')
                            : context.push('/directory/${item.$2}'),
                      ),
                  ],
                ),
              ),
            ),
          SampleDataBanner(text: l.sampleData),
        ],
      ),
    );
  }
}
