import 'package:flutter/material.dart';

import '../../../core/widgets/common.dart';
import '../../../l10n/app_localizations.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final items = [
      (
        Icons.sync_problem_rounded,
        l.statusExplainer,
        'Understand common payment status messages.',
        _Tool.status,
      ),
      (
        Icons.account_tree_rounded,
        l.troubleshooter,
        'Answer simple questions and get a safe next step.',
        _Tool.troubleshooter,
      ),
      (
        Icons.description_rounded,
        l.disputeAssistant,
        'Prepare a complaint summary without sharing credentials.',
        _Tool.dispute,
      ),
      (
        Icons.calculate_rounded,
        l.calculators,
        'Estimate transfer and merchant fees instantly.',
        _Tool.calculator,
      ),
      (
        Icons.health_and_safety_rounded,
        l.emergencyInfo,
        'Know what to protect and who to contact.',
        _Tool.safety,
      ),
    ];
    return Scaffold(
      appBar: AppBar(title: Text(l.help)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 8, 18, 28),
        children: [
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF003B52),
                  Color(0xFF006B97),
                  Color(0xFF69B83B),
                ],
              ),
              borderRadius: BorderRadius.circular(28),
            ),
            child: Row(
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Payment help, made simple',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Choose a tool below. Never enter your PIN, CVV, password or OTP.',
                        style: TextStyle(color: Color(0xFFD8FFF8), height: 1.4),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.all(13),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: .13),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Icon(
                    Icons.shield_outlined,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          SectionHeader(title: l.helpTitle),
          const SizedBox(height: 12),
          for (final item in items)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Card(
                child: InkWell(
                  borderRadius: BorderRadius.circular(24),
                  onTap: () => _openTool(context, item.$4, item.$2),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(11),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary
                                .withValues(alpha: .1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Icon(
                            item.$1,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.$2,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                item.$3,
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant,
                                  height: 1.35,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.arrow_forward_rounded, size: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _openTool(BuildContext context, _Tool tool, String title) =>
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        useSafeArea: true,
        showDragHandle: true,
        builder: (_) => _ToolSheet(tool: tool, title: title),
      );
}

enum _Tool { status, troubleshooter, dispute, calculator, safety }

class _ToolSheet extends StatefulWidget {
  const _ToolSheet({required this.tool, required this.title});
  final _Tool tool;
  final String title;
  @override
  State<_ToolSheet> createState() => _ToolSheetState();
}

class _ToolSheetState extends State<_ToolSheet> {
  String status = 'Pending';
  int troubleStep = 0;
  final amount = TextEditingController();
  final rate = TextEditingController(text: '1');
  final reference = TextEditingController();
  final description = TextEditingController();

  @override
  void dispose() {
    amount.dispose();
    rate.dispose();
    reference.dispose();
    description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.fromLTRB(
      20,
      4,
      20,
      MediaQuery.viewInsetsOf(context).bottom + 24,
    ),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.title,
            style: Theme.of(context).textTheme.headlineSmall
                ?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          if (widget.tool == _Tool.status) _statusTool(),
          if (widget.tool == _Tool.troubleshooter) _troubleshooter(),
          if (widget.tool == _Tool.dispute) _disputeTool(),
          if (widget.tool == _Tool.calculator) _calculator(),
          if (widget.tool == _Tool.safety) _safety(),
        ],
      ),
    ),
  );

  Widget _statusTool() {
    const messages = {
      'Successful': (
        'The payment completed.',
        'Keep the receipt or reference number.',
      ),
      'Failed': (
        'The payment did not complete.',
        'Check your balance and connection before trying once more.',
      ),
      'Pending': (
        'The final result is not available yet.',
        'Do not repeat immediately. Keep the reference and check later.',
      ),
      'Reversed': (
        'The payment was cancelled after processing.',
        'The amount normally returns through your provider; contact them if delayed.',
      ),
      'Declined': (
        'The provider did not approve the payment.',
        'Contact your bank or service provider for the exact reason.',
      ),
    };
    final message = messages[status]!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 14),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: messages.keys
              .map(
                (value) => ChoiceChip(
                  label: Text(value),
                  selected: status == value,
                  onSelected: (_) => setState(() => status = value),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 20),
        _ResultCard(
          icon: Icons.info_outline_rounded,
          title: message.$1,
          body: message.$2,
        ),
      ],
    );
  }

  Widget _troubleshooter() {
    final questions = [
      'What happened?',
      'Was money deducted?',
      'Your recommended next step',
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 14),
        LinearProgressIndicator(
          value: (troubleStep + 1) / 3,
          borderRadius: BorderRadius.circular(99),
        ),
        const SizedBox(height: 20),
        Text(
          questions[troubleStep],
          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
        ),
        const SizedBox(height: 14),
        if (troubleStep == 0) ...[
          _choice('ATM did not dispense cash'),
          _choice('Payment failed or timed out'),
          _choice('Transaction is pending'),
        ] else if (troubleStep == 1) ...[
          _choice('Yes, the amount was deducted'),
          _choice('No, it was not deducted'),
          _choice('I am not sure'),
        ] else ...[
          const _ResultCard(
            icon: Icons.task_alt_rounded,
            title: 'Keep your transaction details',
            body: 'Save the date, approximate time, amount, organization and reference number. Contact your bank or service provider. Do not share your PIN, CVV or OTP.',
          ),
          const SizedBox(height: 14),
          OutlinedButton(
            onPressed: () => setState(() => troubleStep = 0),
            child: const Text('Start again'),
          ),
        ],
      ],
    );
  }

  Widget _choice(String label) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () =>
            setState(() => troubleStep = (troubleStep + 1).clamp(0, 2)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(label),
          ),
        ),
      ),
    ),
  );

  Widget _disputeTool() => Column(
    children: [
      const SizedBox(height: 14),
      TextField(
        controller: reference,
        decoration: const InputDecoration(
          labelText: 'Reference number (optional)',
          prefixIcon: Icon(Icons.tag),
        ),
      ),
      const SizedBox(height: 12),
      TextField(
        controller: amount,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          labelText: 'Amount (AFN)',
          prefixIcon: Icon(Icons.payments_outlined),
        ),
      ),
      const SizedBox(height: 12),
      TextField(
        controller: description,
        maxLines: 3,
        decoration: const InputDecoration(
          labelText: 'What happened?',
          alignLabelWithHint: true,
        ),
      ),
      const SizedBox(height: 16),
      SizedBox(
        width: double.infinity,
        child: FilledButton.icon(
          onPressed: _showSummary,
          icon: const Icon(Icons.description_outlined),
          label: const Text('Prepare summary'),
        ),
      ),
      const SizedBox(height: 10),
      Text(
        'This tool prepares information only; it does not submit or resolve a dispute.',
        style: Theme.of(context).textTheme.bodySmall,
      ),
    ],
  );

  void _showSummary() {
    final summary =
        'Payment issue\nAmount: ${amount.text.isEmpty ? 'Not provided' : '${amount.text} AFN'}\nReference: ${reference.text.isEmpty ? 'Not provided' : reference.text}\nDescription: ${description.text.isEmpty ? 'Not provided' : description.text}';
    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Complaint summary'),
        content: SelectableText(summary),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  Widget _calculator() {
    final value = double.tryParse(amount.text) ?? 0;
    final percentage = double.tryParse(rate.text) ?? 0;
    final fee = value * percentage / 100;
    return Column(
      children: [
        const SizedBox(height: 14),
        TextField(
          controller: amount,
          keyboardType: TextInputType.number,
          onChanged: (_) => setState(() {}),
          decoration: const InputDecoration(
            labelText: 'Amount (AFN)',
            prefixIcon: Icon(Icons.payments_outlined),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: rate,
          keyboardType: TextInputType.number,
          onChanged: (_) => setState(() {}),
          decoration: const InputDecoration(
            labelText: 'Fee percentage',
            prefixIcon: Icon(Icons.percent_rounded),
          ),
        ),
        const SizedBox(height: 18),
        _ResultCard(
          icon: Icons.calculate_outlined,
          title: '${fee.toStringAsFixed(2)} AFN estimated fee',
          body:
              'Total: ${(value + fee).toStringAsFixed(2)} AFN. This is an estimate, not a provider fee quote.',
        ),
      ],
    );
  }

  Widget _safety() => const Column(
    children: [
      SizedBox(height: 14),
      _ResultCard(
        icon: Icons.lock_outline_rounded,
        title: 'Protect private information',
        body:
            'Never share your PIN, CVV, password or one-time code with anyone.',
      ),
      SizedBox(height: 10),
      _ResultCard(
        icon: Icons.receipt_long_outlined,
        title: 'Keep useful details',
        body: 'Keep the amount, date, time, organization and transaction reference.',
      ),
      SizedBox(height: 10),
      _ResultCard(
        icon: Icons.support_agent_rounded,
        title: 'Use official support',
        body: 'Contact the bank or service provider using its verified website or published number.',
      ),
    ],
  );
}

class _ResultCard extends StatelessWidget {
  const _ResultCard({
    required this.icon,
    required this.title,
    required this.body,
  });
  final IconData icon;
  final String title, body;
  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.primaryContainer
          .withValues(alpha: .55),
      borderRadius: BorderRadius.circular(18),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
              const SizedBox(height: 5),
              Text(body, style: const TextStyle(height: 1.4)),
            ],
          ),
        ),
      ],
    ),
  );
}
