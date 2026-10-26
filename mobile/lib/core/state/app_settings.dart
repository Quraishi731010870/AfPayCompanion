import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>(
  (ref) => throw UnimplementedError(),
);

class AppSettings {
  const AppSettings({
    required this.locale,
    required this.themeMode,
    required this.onboardingComplete,
  });
  final Locale locale;
  final ThemeMode themeMode;
  final bool onboardingComplete;
  AppSettings copyWith({
    Locale? locale,
    ThemeMode? themeMode,
    bool? onboardingComplete,
  }) => AppSettings(
    locale: locale ?? this.locale,
    themeMode: themeMode ?? this.themeMode,
    onboardingComplete: onboardingComplete ?? this.onboardingComplete,
  );
}

class AppSettingsNotifier extends Notifier<AppSettings> {
  late SharedPreferences _prefs;
  @override
  AppSettings build() {
    _prefs = ref.watch(sharedPreferencesProvider);
    final language = _prefs.getString('language') ?? 'en';
    final index = _prefs.getInt('themeMode') ?? ThemeMode.system.index;
    return AppSettings(
      locale: Locale(language),
      themeMode: ThemeMode.values[index.clamp(0, ThemeMode.values.length - 1)],
      onboardingComplete: _prefs.getBool('onboardingComplete') ?? false,
    );
  }

  Future<void> setLocale(Locale v) async {
    state = state.copyWith(locale: v);
    await _prefs.setString('language', v.languageCode);
  }

  Future<void> setThemeMode(ThemeMode v) async {
    state = state.copyWith(themeMode: v);
    await _prefs.setInt('themeMode', v.index);
  }

  Future<void> completeOnboarding() async {
    state = state.copyWith(onboardingComplete: true);
    await _prefs.setBool('onboardingComplete', true);
  }
}

final appSettingsProvider = NotifierProvider<AppSettingsNotifier, AppSettings>(
  AppSettingsNotifier.new,
);

class FavoritesNotifier extends Notifier<Set<String>> {
  late SharedPreferences _prefs;
  @override
  Set<String> build() {
    _prefs = ref.watch(sharedPreferencesProvider);
    return (_prefs.getStringList('favorites') ?? []).toSet();
  }

  Future<void> toggle(String id) async {
    final next = {...state};
    next.contains(id) ? next.remove(id) : next.add(id);
    state = next;
    await _prefs.setStringList('favorites', state.toList());
  }
}

final favoritesProvider = NotifierProvider<FavoritesNotifier, Set<String>>(
  FavoritesNotifier.new,
);
