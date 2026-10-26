import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fa.dart';
import 'app_localizations_ps.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fa'),
    Locale('ps'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'AfPay Companion'**
  String get appName;

  /// No description provided for @tagline.
  ///
  /// In en, this message translates to:
  /// **'Your Guide to Digital Payments in Afghanistan'**
  String get tagline;

  /// No description provided for @independentDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'AfPay Companion is an independent informational application.'**
  String get independentDisclaimer;

  /// No description provided for @continueLabel.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueLabel;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get started'**
  String get getStarted;

  /// No description provided for @onboardingFindTitle.
  ///
  /// In en, this message translates to:
  /// **'Find payment services'**
  String get onboardingFindTitle;

  /// No description provided for @onboardingFindBody.
  ///
  /// In en, this message translates to:
  /// **'Find ATMs, POS locations, banks and digital payment services.'**
  String get onboardingFindBody;

  /// No description provided for @onboardingHelpTitle.
  ///
  /// In en, this message translates to:
  /// **'Get clear help'**
  String get onboardingHelpTitle;

  /// No description provided for @onboardingHelpBody.
  ///
  /// In en, this message translates to:
  /// **'Understand payment problems and find the right next step.'**
  String get onboardingHelpBody;

  /// No description provided for @onboardingLearnTitle.
  ///
  /// In en, this message translates to:
  /// **'Stay informed'**
  String get onboardingLearnTitle;

  /// No description provided for @onboardingLearnBody.
  ///
  /// In en, this message translates to:
  /// **'Receive important updates and learn to use digital payments safely.'**
  String get onboardingLearnBody;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @explore.
  ///
  /// In en, this message translates to:
  /// **'Explore'**
  String get explore;

  /// No description provided for @map.
  ///
  /// In en, this message translates to:
  /// **'Map'**
  String get map;

  /// No description provided for @help.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get help;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @goodMorning.
  ///
  /// In en, this message translates to:
  /// **'Good morning'**
  String get goodMorning;

  /// No description provided for @welcomeMessage.
  ///
  /// In en, this message translates to:
  /// **'How can we help with your payments today?'**
  String get welcomeMessage;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search banks, ATMs, POS, services…'**
  String get searchHint;

  /// No description provided for @quickActions.
  ///
  /// In en, this message translates to:
  /// **'Quick actions'**
  String get quickActions;

  /// No description provided for @findAtm.
  ///
  /// In en, this message translates to:
  /// **'Find ATM'**
  String get findAtm;

  /// No description provided for @findPos.
  ///
  /// In en, this message translates to:
  /// **'Find POS'**
  String get findPos;

  /// No description provided for @findBank.
  ///
  /// In en, this message translates to:
  /// **'Find bank'**
  String get findBank;

  /// No description provided for @findAgent.
  ///
  /// In en, this message translates to:
  /// **'Find agent'**
  String get findAgent;

  /// No description provided for @paymentHelp.
  ///
  /// In en, this message translates to:
  /// **'Payment help'**
  String get paymentHelp;

  /// No description provided for @disputeHelp.
  ///
  /// In en, this message translates to:
  /// **'Dispute help'**
  String get disputeHelp;

  /// No description provided for @nearbyServices.
  ///
  /// In en, this message translates to:
  /// **'Nearby services'**
  String get nearbyServices;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get viewAll;

  /// No description provided for @havingProblem.
  ///
  /// In en, this message translates to:
  /// **'Having a payment problem?'**
  String get havingProblem;

  /// No description provided for @problemBody.
  ///
  /// In en, this message translates to:
  /// **'Answer a few simple questions and get a clear next step.'**
  String get problemBody;

  /// No description provided for @getHelp.
  ///
  /// In en, this message translates to:
  /// **'Get help'**
  String get getHelp;

  /// No description provided for @learn.
  ///
  /// In en, this message translates to:
  /// **'Learn'**
  String get learn;

  /// No description provided for @announcements.
  ///
  /// In en, this message translates to:
  /// **'Announcements'**
  String get announcements;

  /// No description provided for @sampleData.
  ///
  /// In en, this message translates to:
  /// **'Development sample data — not verified operational information'**
  String get sampleData;

  /// No description provided for @banking.
  ///
  /// In en, this message translates to:
  /// **'Banking'**
  String get banking;

  /// No description provided for @digitalPayments.
  ///
  /// In en, this message translates to:
  /// **'Digital payments'**
  String get digitalPayments;

  /// No description provided for @merchantServices.
  ///
  /// In en, this message translates to:
  /// **'Merchant services'**
  String get merchantServices;

  /// No description provided for @support.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get support;

  /// No description provided for @education.
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get education;

  /// No description provided for @banks.
  ///
  /// In en, this message translates to:
  /// **'Banks'**
  String get banks;

  /// No description provided for @branches.
  ///
  /// In en, this message translates to:
  /// **'Branches'**
  String get branches;

  /// No description provided for @atms.
  ///
  /// In en, this message translates to:
  /// **'ATMs'**
  String get atms;

  /// No description provided for @emis.
  ///
  /// In en, this message translates to:
  /// **'EMIs'**
  String get emis;

  /// No description provided for @paymentInstitutions.
  ///
  /// In en, this message translates to:
  /// **'Payment institutions'**
  String get paymentInstitutions;

  /// No description provided for @wallets.
  ///
  /// In en, this message translates to:
  /// **'Wallets'**
  String get wallets;

  /// No description provided for @pos.
  ///
  /// In en, this message translates to:
  /// **'POS locations'**
  String get pos;

  /// No description provided for @agents.
  ///
  /// In en, this message translates to:
  /// **'Agents'**
  String get agents;

  /// No description provided for @troubleshooting.
  ///
  /// In en, this message translates to:
  /// **'Troubleshooting'**
  String get troubleshooting;

  /// No description provided for @disputes.
  ///
  /// In en, this message translates to:
  /// **'Disputes'**
  String get disputes;

  /// No description provided for @faqs.
  ///
  /// In en, this message translates to:
  /// **'FAQs'**
  String get faqs;

  /// No description provided for @securityTips.
  ///
  /// In en, this message translates to:
  /// **'Security tips'**
  String get securityTips;

  /// No description provided for @mapComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Map foundation ready'**
  String get mapComingSoon;

  /// No description provided for @mapComingSoonBody.
  ///
  /// In en, this message translates to:
  /// **'Provider integration, verified markers and contextual location permission arrive in Phase 3.'**
  String get mapComingSoonBody;

  /// No description provided for @manualSearch.
  ///
  /// In en, this message translates to:
  /// **'Search an area'**
  String get manualSearch;

  /// No description provided for @helpTitle.
  ///
  /// In en, this message translates to:
  /// **'What do you need help with?'**
  String get helpTitle;

  /// No description provided for @statusExplainer.
  ///
  /// In en, this message translates to:
  /// **'Payment status explainer'**
  String get statusExplainer;

  /// No description provided for @troubleshooter.
  ///
  /// In en, this message translates to:
  /// **'Guided troubleshooter'**
  String get troubleshooter;

  /// No description provided for @disputeAssistant.
  ///
  /// In en, this message translates to:
  /// **'Prepare a dispute'**
  String get disputeAssistant;

  /// No description provided for @calculators.
  ///
  /// In en, this message translates to:
  /// **'Payment calculators'**
  String get calculators;

  /// No description provided for @emergencyInfo.
  ///
  /// In en, this message translates to:
  /// **'Important help information'**
  String get emergencyInfo;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @systemTheme.
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get systemTheme;

  /// No description provided for @lightTheme.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get lightTheme;

  /// No description provided for @darkTheme.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get darkTheme;

  /// No description provided for @favorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @privacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get privacy;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @sendFeedback.
  ///
  /// In en, this message translates to:
  /// **'Send feedback'**
  String get sendFeedback;

  /// No description provided for @locationPermission.
  ///
  /// In en, this message translates to:
  /// **'Location permission'**
  String get locationPermission;

  /// No description provided for @notRequested.
  ///
  /// In en, this message translates to:
  /// **'Not requested'**
  String get notRequested;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @recentSearches.
  ///
  /// In en, this message translates to:
  /// **'Recent searches'**
  String get recentSearches;

  /// No description provided for @noResults.
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get noResults;

  /// No description provided for @noResultsBody.
  ///
  /// In en, this message translates to:
  /// **'Try another name, category, or location.'**
  String get noResultsBody;

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// No description provided for @verified.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get verified;

  /// No description provided for @pendingVerification.
  ///
  /// In en, this message translates to:
  /// **'Pending verification'**
  String get pendingVerification;

  /// No description provided for @communityReported.
  ///
  /// In en, this message translates to:
  /// **'Community reported'**
  String get communityReported;

  /// No description provided for @outdated.
  ///
  /// In en, this message translates to:
  /// **'Outdated'**
  String get outdated;

  /// No description provided for @lastVerified.
  ///
  /// In en, this message translates to:
  /// **'Last verified'**
  String get lastVerified;

  /// No description provided for @services.
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get services;

  /// No description provided for @contact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get contact;

  /// No description provided for @locations.
  ///
  /// In en, this message translates to:
  /// **'Locations'**
  String get locations;

  /// No description provided for @officialSource.
  ///
  /// In en, this message translates to:
  /// **'Source information'**
  String get officialSource;

  /// No description provided for @reportIncorrect.
  ///
  /// In en, this message translates to:
  /// **'Report incorrect information'**
  String get reportIncorrect;

  /// No description provided for @directions.
  ///
  /// In en, this message translates to:
  /// **'Directions'**
  String get directions;

  /// No description provided for @website.
  ///
  /// In en, this message translates to:
  /// **'Website'**
  String get website;

  /// No description provided for @offline.
  ///
  /// In en, this message translates to:
  /// **'Offline mode'**
  String get offline;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @somethingWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get somethingWrong;

  /// No description provided for @noFavorites.
  ///
  /// In en, this message translates to:
  /// **'No favorites yet'**
  String get noFavorites;

  /// No description provided for @noFavoritesBody.
  ///
  /// In en, this message translates to:
  /// **'Save useful services and organizations for quick access.'**
  String get noFavoritesBody;

  /// No description provided for @directory.
  ///
  /// In en, this message translates to:
  /// **'Directory'**
  String get directory;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fa', 'ps'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fa':
      return AppLocalizationsFa();
    case 'ps':
      return AppLocalizationsPs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
