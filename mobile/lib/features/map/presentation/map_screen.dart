import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/common.dart';
import '../../../l10n/app_localizations.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l.map)),
      body: InfoState(
        icon: Icons.map_outlined,
        title: l.mapComingSoon,
        body: l.mapComingSoonBody,
        action: l.manualSearch,
        onAction: () => context.push('/search'),
      ),
    );
  }
}
