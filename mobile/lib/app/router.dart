import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../core/state/app_settings.dart';
import '../features/explore/presentation/explore_screen.dart';
import '../features/help/presentation/help_screen.dart';
import '../features/home/presentation/home_screen.dart';
import '../features/map/presentation/map_screen.dart';
import '../features/onboarding/presentation/onboarding_screen.dart';
import '../features/organizations/presentation/directory_screen.dart';
import '../features/organizations/presentation/organization_detail_screen.dart';
import '../features/profile/presentation/profile_screen.dart';
import '../features/search/presentation/search_screen.dart';
import 'shell.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final complete = ref.read(appSettingsProvider).onboardingComplete;
  return GoRouter(
    initialLocation: complete ? '/home' : '/onboarding',
    routes: [
      GoRoute(path: '/onboarding', builder: (_, _) => const OnboardingScreen()),
      StatefulShellRoute.indexedStack(
        builder: (_, _, shell) => AppShell(shell: shell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(path: '/home', builder: (_, _) => const HomeScreen()),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/explore',
                builder: (_, _) => const ExploreScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(path: '/map', builder: (_, _) => const MapScreen()),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(path: '/help', builder: (_, _) => const HelpScreen()),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                builder: (_, _) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(path: '/search', builder: (_, _) => const SearchScreen()),
      GoRoute(
        path: '/directory/:type',
        builder: (_, s) => DirectoryScreen(type: s.pathParameters['type']!),
      ),
      GoRoute(
        path: '/organization/:id',
        builder: (_, s) =>
            OrganizationDetailScreen(id: s.pathParameters['id']!),
      ),
    ],
  );
});
