// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get helloWorld => 'Hello World!';

  @override
  String get areYouSure => 'Are you sure?';

  @override
  String get cancel => 'Cancel';

  @override
  String get ok => 'Ok';

  @override
  String get close => 'Close';

  @override
  String get delete => 'Delete';

  @override
  String get deleteAll => 'Delete all';

  @override
  String get skip => 'Skip';

  @override
  String get next => 'Next';

  @override
  String get save => 'Save';

  @override
  String get experimental => 'Experimental';

  @override
  String get comingSoon => 'Coming soon';

  @override
  String get textFieldHint => 'Start writing about your day..';

  @override
  String get currentlyWriting => 'Currently writing..';

  @override
  String get onboardingFirstTitle => 'Welcome!';

  @override
  String get onboardingFirstMessage =>
      'I\'m very glad you\'re here. I\'ll show you a few tips and tricks that are very useful in this app!';

  @override
  String get onboardingFirstAction => 'Let\'s go!';

  @override
  String get onboardingSecondTitle => 'First off\nKeyboard binds!';

  @override
  String get onboardingThirdTitle =>
      'Here you see the history of your journals!\nThey stack horizontally as the days progress.';

  @override
  String get onboardingFourthTitle => 'You\'re done!';

  @override
  String get onboardingFourthMessage => 'Very nice. Let\'s get you writing!';

  @override
  String get onboardingFourthAction => 'Start writing!';

  @override
  String get bindsPreferences => 'Preferences';

  @override
  String get bindsPreferencesKey => '⌘,';

  @override
  String get bindsQuickSave => 'Quick save';

  @override
  String get bindsQuickSaveKey => '⌘S';

  @override
  String get bindsFocusToggle => 'Focus mode toggle';

  @override
  String get bindsFocusToggleKey => '⇧⌘F';

  @override
  String get bindsTextSizeIncrease => 'Increase text size';

  @override
  String get bindsTextSizeIncreaseKey => '⌘+';

  @override
  String get bindsTextSizeDecrease => 'Decrease text size';

  @override
  String get bindsTextSizeDecreaseKey => '⌘-';

  @override
  String get bindsJournalNewer => 'Move to newer journal';

  @override
  String get bindsJournalNewerKey => '⌘←';

  @override
  String get bindsJournalOlder => 'Move to older journal';

  @override
  String get bindsJournalOlderKey => '⌘→';

  @override
  String get deleteJournalSingle =>
      'Are you sure you want to remove this journal?';

  @override
  String get deleteJournalAll =>
      'Are you sure you want to remove all journals? This cannot be undone';

  @override
  String get menuAbout => 'About';

  @override
  String get menuSave => 'Save Journal';

  @override
  String get menuToggleFocusMode => 'Toggle focus mode';

  @override
  String get menuTextSizeIncrease => 'Increase text size';

  @override
  String get menuTextSizeDecrease => 'Decrease text size';

  @override
  String get menuTextSizeReset => 'Reset text size';

  @override
  String get menuStepOlder => 'Older journal';

  @override
  String get menuStepNewer => 'Newer journal';

  @override
  String get menuPreferences => 'Preferences';

  @override
  String get menuThemeModeAuto => 'Theme: Auto';

  @override
  String get menuThemeModeLight => 'Theme: Light';

  @override
  String get menuThemeModeDark => 'Theme: Dark';

  @override
  String get messagesThemeChanged => 'Theme';

  @override
  String get messagesTextSizeChanged => 'Text size';

  @override
  String get messagesTextSizeReset => 'Reset text size';

  @override
  String get messagesFocusModeChanged => 'Focus mode';

  @override
  String get messagesFocusModeDisabled => 'Disabled';

  @override
  String get messagesFocusModeEnabled => 'Enabled';

  @override
  String get preferencesDonate => 'Donate';

  @override
  String get preferencesDonateDescription =>
      'Help me develop this app further!';

  @override
  String get preferencesProUnlock => 'Unlock PRO features';

  @override
  String get preferencesProUnlockDescription =>
      'Buy the PRO version of this app to unlock all kinds of cool features';

  @override
  String get preferencesOnboardingReset => 'Walkthrough replay';

  @override
  String get preferencesOnboardingResetDescription =>
      'See the onboarding steps again, maybe you missed something!';

  @override
  String get preferencesOnboardingResetSuccess =>
      'Successfully reset onboarding. Restart the app to run the onboarding again';

  @override
  String get preferencesTextSizeReset => 'Set default text size';

  @override
  String get preferencesTextSizeResetDescription =>
      'Set a more comfortable text size';

  @override
  String get preferencesTextSizeResetSuccess => 'Successfully reset text size';

  @override
  String get preferencesTextAnimations => 'Text animations';

  @override
  String get preferencesTextAnimationsDescription =>
      'Show animating text and indicators when writing';

  @override
  String get preferencesTextAnimationsSuccessDisabled =>
      'Text animations disabled';

  @override
  String get preferencesTextAnimationsSuccessEnabled =>
      'Text animations enabled';

  @override
  String get preferencesExportJournals => 'Export journals';

  @override
  String get preferencesExportJournalsDescription =>
      'Export all your journals into text files to store for later';

  @override
  String get preferencesDeleteAllJournals => 'Delete all journals';

  @override
  String get preferencesDeleteAllJournalsDescription =>
      'Delete all your journals. Be careful, this cannot be undone!';

  @override
  String get preferencesTheme => 'Theme';

  @override
  String get preferencesThemeAuto => 'Automatic';

  @override
  String get preferencesThemeDark => 'Dark';

  @override
  String get preferencesThemeLight => 'Light';

  @override
  String aboutVersion(String version, String buildNumber) {
    return '$version - Build: $buildNumber';
  }
}
