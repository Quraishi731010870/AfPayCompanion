import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final items = [
      (
        Icons.sync_problem,
        l.statusExplainer,
        'Understand successful, failed, reversed, pending and declined payments.',
      ),
      (
        Icons.account_tree_outlined,
        l.troubleshooter,
        'Answer guided questions to find a safe next step.',
      ),
      (
        Icons.description_outlined,
        l.disputeAssistant,
        'Prepare a complaint summary without sharing credentials.',
      ),
      (
        Icons.calculate_outlined,
        l.calculators,
        'Estimate fees, percentages, savings and installments.',
      ),
      (
        Icons.contact_support_outlined,
        l.emergencyInfo,
        'Know who to contact and what information to keep.',
      ),
    ];
    return Scaffold(
      appBar: AppBar(title: Text(l.help)),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Text(
            l.helpTitle,
            style: Theme.of(context).textTheme.headlineSmall
                ?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 18),
          for (final item in items)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Card(
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: CircleAvatar(child: Icon(item.$1)),
                  title: Text(
                    item.$2,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(item.$3),
                  ),
                  trailing: const Icon(Icons.chevron_right),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
