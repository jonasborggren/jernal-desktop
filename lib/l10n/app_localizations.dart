import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

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

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
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
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// No description provided for @helloWorld.
  ///
  /// In en, this message translates to:
  /// **'Hello World!'**
  String get helloWorld;

  /// No description provided for @areYouSure.
  ///
  /// In en, this message translates to:
  /// **'Are you sure?'**
  String get areYouSure;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get ok;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @deleteAll.
  ///
  /// In en, this message translates to:
  /// **'Delete all'**
  String get deleteAll;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @experimental.
  ///
  /// In en, this message translates to:
  /// **'Experimental'**
  String get experimental;

  /// No description provided for @comingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming soon'**
  String get comingSoon;

  /// No description provided for @textFieldHint.
  ///
  /// In en, this message translates to:
  /// **'Start writing about your day..'**
  String get textFieldHint;

  /// No description provided for @currentlyWriting.
  ///
  /// In en, this message translates to:
  /// **'Currently writing..'**
  String get currentlyWriting;

  /// No description provided for @onboardingFirstTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome!'**
  String get onboardingFirstTitle;

  /// No description provided for @onboardingFirstMessage.
  ///
  /// In en, this message translates to:
  /// **'I\'m very glad you\'re here. I\'ll show you a few tips and tricks that are very useful in this app!'**
  String get onboardingFirstMessage;

  /// No description provided for @onboardingFirstAction.
  ///
  /// In en, this message translates to:
  /// **'Let\'s go!'**
  String get onboardingFirstAction;

  /// No description provided for @onboardingSecondTitle.
  ///
  /// In en, this message translates to:
  /// **'First off\nKeyboard binds!'**
  String get onboardingSecondTitle;

  /// No description provided for @onboardingThirdTitle.
  ///
  /// In en, this message translates to:
  /// **'Here you see the history of your journals!\nThey stack horizontally as the days progress.'**
  String get onboardingThirdTitle;

  /// No description provided for @onboardingFourthTitle.
  ///
  /// In en, this message translates to:
  /// **'You\'re done!'**
  String get onboardingFourthTitle;

  /// No description provided for @onboardingFourthMessage.
  ///
  /// In en, this message translates to:
  /// **'Very nice. Let\'s get you writing!'**
  String get onboardingFourthMessage;

  /// No description provided for @onboardingFourthAction.
  ///
  /// In en, this message translates to:
  /// **'Start writing!'**
  String get onboardingFourthAction;

  /// No description provided for @bindsPreferences.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get bindsPreferences;

  /// No description provided for @bindsPreferencesKey.
  ///
  /// In en, this message translates to:
  /// **'⌘,'**
  String get bindsPreferencesKey;

  /// No description provided for @bindsQuickSave.
  ///
  /// In en, this message translates to:
  /// **'Quick save'**
  String get bindsQuickSave;

  /// No description provided for @bindsQuickSaveKey.
  ///
  /// In en, this message translates to:
  /// **'⌘S'**
  String get bindsQuickSaveKey;

  /// No description provided for @bindsFocusToggle.
  ///
  /// In en, this message translates to:
  /// **'Focus mode toggle'**
  String get bindsFocusToggle;

  /// No description provided for @bindsFocusToggleKey.
  ///
  /// In en, this message translates to:
  /// **'⇧⌘F'**
  String get bindsFocusToggleKey;

  /// No description provided for @bindsTextSizeIncrease.
  ///
  /// In en, this message translates to:
  /// **'Increase text size'**
  String get bindsTextSizeIncrease;

  /// No description provided for @bindsTextSizeIncreaseKey.
  ///
  /// In en, this message translates to:
  /// **'⌘+'**
  String get bindsTextSizeIncreaseKey;

  /// No description provided for @bindsTextSizeDecrease.
  ///
  /// In en, this message translates to:
  /// **'Decrease text size'**
  String get bindsTextSizeDecrease;

  /// No description provided for @bindsTextSizeDecreaseKey.
  ///
  /// In en, this message translates to:
  /// **'⌘-'**
  String get bindsTextSizeDecreaseKey;

  /// No description provided for @bindsJournalNewer.
  ///
  /// In en, this message translates to:
  /// **'Move to newer journal'**
  String get bindsJournalNewer;

  /// No description provided for @bindsJournalNewerKey.
  ///
  /// In en, this message translates to:
  /// **'⌘←'**
  String get bindsJournalNewerKey;

  /// No description provided for @bindsJournalOlder.
  ///
  /// In en, this message translates to:
  /// **'Move to older journal'**
  String get bindsJournalOlder;

  /// No description provided for @bindsJournalOlderKey.
  ///
  /// In en, this message translates to:
  /// **'⌘→'**
  String get bindsJournalOlderKey;

  /// No description provided for @deleteJournalSingle.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to remove this journal?'**
  String get deleteJournalSingle;

  /// No description provided for @deleteJournalAll.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to remove all journals? This cannot be undone'**
  String get deleteJournalAll;

  /// No description provided for @menuAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get menuAbout;

  /// No description provided for @menuSave.
  ///
  /// In en, this message translates to:
  /// **'Save Journal'**
  String get menuSave;

  /// No description provided for @menuToggleFocusMode.
  ///
  /// In en, this message translates to:
  /// **'Toggle focus mode'**
  String get menuToggleFocusMode;

  /// No description provided for @menuTextSizeIncrease.
  ///
  /// In en, this message translates to:
  /// **'Increase text size'**
  String get menuTextSizeIncrease;

  /// No description provided for @menuTextSizeDecrease.
  ///
  /// In en, this message translates to:
  /// **'Decrease text size'**
  String get menuTextSizeDecrease;

  /// No description provided for @menuTextSizeReset.
  ///
  /// In en, this message translates to:
  /// **'Reset text size'**
  String get menuTextSizeReset;

  /// No description provided for @menuStepOlder.
  ///
  /// In en, this message translates to:
  /// **'Older journal'**
  String get menuStepOlder;

  /// No description provided for @menuStepNewer.
  ///
  /// In en, this message translates to:
  /// **'Newer journal'**
  String get menuStepNewer;

  /// No description provided for @menuPreferences.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get menuPreferences;

  /// No description provided for @menuThemeModeAuto.
  ///
  /// In en, this message translates to:
  /// **'Theme: Auto'**
  String get menuThemeModeAuto;

  /// No description provided for @menuThemeModeLight.
  ///
  /// In en, this message translates to:
  /// **'Theme: Light'**
  String get menuThemeModeLight;

  /// No description provided for @menuThemeModeDark.
  ///
  /// In en, this message translates to:
  /// **'Theme: Dark'**
  String get menuThemeModeDark;

  /// No description provided for @messagesThemeChanged.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get messagesThemeChanged;

  /// No description provided for @messagesTextSizeChanged.
  ///
  /// In en, this message translates to:
  /// **'Text size'**
  String get messagesTextSizeChanged;

  /// No description provided for @messagesTextSizeReset.
  ///
  /// In en, this message translates to:
  /// **'Reset text size'**
  String get messagesTextSizeReset;

  /// No description provided for @messagesFocusModeChanged.
  ///
  /// In en, this message translates to:
  /// **'Focus mode'**
  String get messagesFocusModeChanged;

  /// No description provided for @messagesFocusModeDisabled.
  ///
  /// In en, this message translates to:
  /// **'Disabled'**
  String get messagesFocusModeDisabled;

  /// No description provided for @messagesFocusModeEnabled.
  ///
  /// In en, this message translates to:
  /// **'Enabled'**
  String get messagesFocusModeEnabled;

  /// No description provided for @preferencesDonate.
  ///
  /// In en, this message translates to:
  /// **'Donate'**
  String get preferencesDonate;

  /// No description provided for @preferencesDonateDescription.
  ///
  /// In en, this message translates to:
  /// **'Help me develop this app further!'**
  String get preferencesDonateDescription;

  /// No description provided for @preferencesProUnlock.
  ///
  /// In en, this message translates to:
  /// **'Unlock PRO features'**
  String get preferencesProUnlock;

  /// No description provided for @preferencesProUnlockDescription.
  ///
  /// In en, this message translates to:
  /// **'Buy the PRO version of this app to unlock all kinds of cool features'**
  String get preferencesProUnlockDescription;

  /// No description provided for @preferencesOnboardingReset.
  ///
  /// In en, this message translates to:
  /// **'Walkthrough replay'**
  String get preferencesOnboardingReset;

  /// No description provided for @preferencesOnboardingResetDescription.
  ///
  /// In en, this message translates to:
  /// **'See the onboarding steps again, maybe you missed something!'**
  String get preferencesOnboardingResetDescription;

  /// No description provided for @preferencesOnboardingResetSuccess.
  ///
  /// In en, this message translates to:
  /// **'Successfully reset onboarding. Restart the app to run the onboarding again'**
  String get preferencesOnboardingResetSuccess;

  /// No description provided for @preferencesTextSizeReset.
  ///
  /// In en, this message translates to:
  /// **'Set default text size'**
  String get preferencesTextSizeReset;

  /// No description provided for @preferencesTextSizeResetDescription.
  ///
  /// In en, this message translates to:
  /// **'Set a more comfortable text size'**
  String get preferencesTextSizeResetDescription;

  /// No description provided for @preferencesTextSizeResetSuccess.
  ///
  /// In en, this message translates to:
  /// **'Successfully reset text size'**
  String get preferencesTextSizeResetSuccess;

  /// No description provided for @preferencesTextAnimations.
  ///
  /// In en, this message translates to:
  /// **'Text animations'**
  String get preferencesTextAnimations;

  /// No description provided for @preferencesTextAnimationsDescription.
  ///
  /// In en, this message translates to:
  /// **'Show animating text and indicators when writing'**
  String get preferencesTextAnimationsDescription;

  /// No description provided for @preferencesTextAnimationsSuccessDisabled.
  ///
  /// In en, this message translates to:
  /// **'Text animations disabled'**
  String get preferencesTextAnimationsSuccessDisabled;

  /// No description provided for @preferencesTextAnimationsSuccessEnabled.
  ///
  /// In en, this message translates to:
  /// **'Text animations enabled'**
  String get preferencesTextAnimationsSuccessEnabled;

  /// No description provided for @preferencesExportJournals.
  ///
  /// In en, this message translates to:
  /// **'Export journals'**
  String get preferencesExportJournals;

  /// No description provided for @preferencesExportJournalsDescription.
  ///
  /// In en, this message translates to:
  /// **'Export all your journals into text files to store for later'**
  String get preferencesExportJournalsDescription;

  /// No description provided for @preferencesDeleteAllJournals.
  ///
  /// In en, this message translates to:
  /// **'Delete all journals'**
  String get preferencesDeleteAllJournals;

  /// No description provided for @preferencesDeleteAllJournalsDescription.
  ///
  /// In en, this message translates to:
  /// **'Delete all your journals. Be careful, this cannot be undone!'**
  String get preferencesDeleteAllJournalsDescription;

  /// No description provided for @preferencesTheme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get preferencesTheme;

  /// No description provided for @preferencesThemeAuto.
  ///
  /// In en, this message translates to:
  /// **'Automatic'**
  String get preferencesThemeAuto;

  /// No description provided for @preferencesThemeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get preferencesThemeDark;

  /// No description provided for @preferencesThemeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get preferencesThemeLight;

  /// No description provided for @aboutVersion.
  ///
  /// In en, this message translates to:
  /// **'{version} - Build: {buildNumber}'**
  String aboutVersion(String version, String buildNumber);
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
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
