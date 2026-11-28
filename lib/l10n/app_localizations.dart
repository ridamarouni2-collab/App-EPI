import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_fr.dart';

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
    Locale('ar'),
    Locale('fr'),
  ];

  /// No description provided for @appName.
  ///
  /// In fr, this message translates to:
  /// **'UNDERGROUND SCAN AI'**
  String get appName;

  /// No description provided for @appTagline.
  ///
  /// In fr, this message translates to:
  /// **'Investigation des réseaux enterrés & gestion HSE'**
  String get appTagline;

  /// No description provided for @splashLoading.
  ///
  /// In fr, this message translates to:
  /// **'Initialisation…'**
  String get splashLoading;

  /// No description provided for @loginTitle.
  ///
  /// In fr, this message translates to:
  /// **'Connexion'**
  String get loginTitle;

  /// No description provided for @loginSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Accédez à votre espace d\'inspection'**
  String get loginSubtitle;

  /// No description provided for @emailLabel.
  ///
  /// In fr, this message translates to:
  /// **'Adresse e-mail'**
  String get emailLabel;

  /// No description provided for @passwordLabel.
  ///
  /// In fr, this message translates to:
  /// **'Mot de passe'**
  String get passwordLabel;

  /// No description provided for @signIn.
  ///
  /// In fr, this message translates to:
  /// **'Se connecter'**
  String get signIn;

  /// No description provided for @forgotPassword.
  ///
  /// In fr, this message translates to:
  /// **'Mot de passe oublié ?'**
  String get forgotPassword;

  /// No description provided for @showPassword.
  ///
  /// In fr, this message translates to:
  /// **'Afficher le mot de passe'**
  String get showPassword;

  /// No description provided for @hidePassword.
  ///
  /// In fr, this message translates to:
  /// **'Masquer le mot de passe'**
  String get hidePassword;

  /// No description provided for @emailRequired.
  ///
  /// In fr, this message translates to:
  /// **'L\'adresse e-mail est obligatoire'**
  String get emailRequired;

  /// No description provided for @emailInvalid.
  ///
  /// In fr, this message translates to:
  /// **'Adresse e-mail invalide'**
  String get emailInvalid;

  /// No description provided for @passwordRequired.
  ///
  /// In fr, this message translates to:
  /// **'Le mot de passe est obligatoire'**
  String get passwordRequired;

  /// No description provided for @passwordTooShort.
  ///
  /// In fr, this message translates to:
  /// **'Au moins {count} caractères'**
  String passwordTooShort(int count);

  /// No description provided for @errorInvalidCredentials.
  ///
  /// In fr, this message translates to:
  /// **'E-mail ou mot de passe incorrect'**
  String get errorInvalidCredentials;

  /// No description provided for @errorUnavailableInDemo.
  ///
  /// In fr, this message translates to:
  /// **'Fonction indisponible en mode démonstration : elle nécessite Firebase (phase 2).'**
  String get errorUnavailableInDemo;

  /// No description provided for @errorNetwork.
  ///
  /// In fr, this message translates to:
  /// **'Erreur réseau. Vérifiez votre connexion.'**
  String get errorNetwork;

  /// No description provided for @errorUnknown.
  ///
  /// In fr, this message translates to:
  /// **'Une erreur inattendue s\'est produite.'**
  String get errorUnknown;

  /// No description provided for @demoModeTitle.
  ///
  /// In fr, this message translates to:
  /// **'Mode démonstration local'**
  String get demoModeTitle;

  /// No description provided for @demoModeBody.
  ///
  /// In fr, this message translates to:
  /// **'Firebase n\'est pas encore configuré (phase 2). La connexion utilise des comptes de démonstration stockés localement. Mot de passe commun : {password}'**
  String demoModeBody(String password);

  /// No description provided for @demoAccountsTitle.
  ///
  /// In fr, this message translates to:
  /// **'Comptes de démonstration'**
  String get demoAccountsTitle;

  /// No description provided for @useThisAccount.
  ///
  /// In fr, this message translates to:
  /// **'Utiliser ce compte'**
  String get useThisAccount;

  /// No description provided for @forgotPasswordTitle.
  ///
  /// In fr, this message translates to:
  /// **'Réinitialiser le mot de passe'**
  String get forgotPasswordTitle;

  /// No description provided for @forgotPasswordBody.
  ///
  /// In fr, this message translates to:
  /// **'Saisissez votre adresse e-mail. Un lien de réinitialisation vous sera envoyé.'**
  String get forgotPasswordBody;

  /// No description provided for @sendResetLink.
  ///
  /// In fr, this message translates to:
  /// **'Envoyer le lien'**
  String get sendResetLink;

  /// No description provided for @resetLinkSent.
  ///
  /// In fr, this message translates to:
  /// **'Si un compte existe pour {email}, un lien de réinitialisation a été envoyé.'**
  String resetLinkSent(String email);

  /// No description provided for @backToLogin.
  ///
  /// In fr, this message translates to:
  /// **'Retour à la connexion'**
  String get backToLogin;

  /// No description provided for @roleAdministrator.
  ///
  /// In fr, this message translates to:
  /// **'Administrateur'**
  String get roleAdministrator;

  /// No description provided for @roleMaintenance.
  ///
  /// In fr, this message translates to:
  /// **'Maintenance'**
  String get roleMaintenance;

  /// No description provided for @roleHse.
  ///
  /// In fr, this message translates to:
  /// **'HSE'**
  String get roleHse;

  /// No description provided for @roleInspector.
  ///
  /// In fr, this message translates to:
  /// **'Inspecteur'**
  String get roleInspector;

  /// No description provided for @dashboardTitle.
  ///
  /// In fr, this message translates to:
  /// **'Tableau de bord'**
  String get dashboardTitle;

  /// No description provided for @greeting.
  ///
  /// In fr, this message translates to:
  /// **'Bonjour, {name}'**
  String greeting(String name);

  /// No description provided for @dashboardSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Synthèse des inspections de réseaux enterrés'**
  String get dashboardSubtitle;

  /// No description provided for @hseWarning.
  ///
  /// In fr, this message translates to:
  /// **'AVERTISSEMENT : Réseau enterré possible. Ne pas percer avant vérification et autorisation.'**
  String get hseWarning;

  /// No description provided for @demoDataBanner.
  ///
  /// In fr, this message translates to:
  /// **'Données de démonstration affichées : elles ne correspondent à aucune inspection réelle.'**
  String get demoDataBanner;

  /// No description provided for @demoBadge.
  ///
  /// In fr, this message translates to:
  /// **'DÉMO'**
  String get demoBadge;

  /// No description provided for @keyIndicators.
  ///
  /// In fr, this message translates to:
  /// **'Indicateurs clés'**
  String get keyIndicators;

  /// No description provided for @statInspections.
  ///
  /// In fr, this message translates to:
  /// **'Inspections'**
  String get statInspections;

  /// No description provided for @statScanSessions.
  ///
  /// In fr, this message translates to:
  /// **'Sessions de scan'**
  String get statScanSessions;

  /// No description provided for @statSuspectedLocations.
  ///
  /// In fr, this message translates to:
  /// **'Emplacements suspectés'**
  String get statSuspectedLocations;

  /// No description provided for @statSuspectedHint.
  ///
  /// In fr, this message translates to:
  /// **'Hypothèses non confirmées'**
  String get statSuspectedHint;

  /// No description provided for @statVerifiedNetworks.
  ///
  /// In fr, this message translates to:
  /// **'Réseaux vérifiés'**
  String get statVerifiedNetworks;

  /// No description provided for @statVerifiedHint.
  ///
  /// In fr, this message translates to:
  /// **'Vérification physique'**
  String get statVerifiedHint;

  /// No description provided for @statOpenRiskZones.
  ///
  /// In fr, this message translates to:
  /// **'Zones à risque ouvertes'**
  String get statOpenRiskZones;

  /// No description provided for @evidenceLevels.
  ///
  /// In fr, this message translates to:
  /// **'Niveaux de preuve'**
  String get evidenceLevels;

  /// No description provided for @evidenceLevelsHint.
  ///
  /// In fr, this message translates to:
  /// **'Un smartphone ne voit pas à travers le béton. Chaque information est classée selon sa source.'**
  String get evidenceLevelsHint;

  /// No description provided for @statusSuspected.
  ///
  /// In fr, this message translates to:
  /// **'Suspecté'**
  String get statusSuspected;

  /// No description provided for @statusDocumented.
  ///
  /// In fr, this message translates to:
  /// **'Documenté'**
  String get statusDocumented;

  /// No description provided for @statusPhysicallyVerified.
  ///
  /// In fr, this message translates to:
  /// **'Vérifié physiquement'**
  String get statusPhysicallyVerified;

  /// No description provided for @statusRejected.
  ///
  /// In fr, this message translates to:
  /// **'Rejeté'**
  String get statusRejected;

  /// No description provided for @modules.
  ///
  /// In fr, this message translates to:
  /// **'Modules'**
  String get modules;

  /// No description provided for @moduleScanner.
  ///
  /// In fr, this message translates to:
  /// **'Scanner'**
  String get moduleScanner;

  /// No description provided for @moduleAiAnalysis.
  ///
  /// In fr, this message translates to:
  /// **'Analyse IA'**
  String get moduleAiAnalysis;

  /// No description provided for @moduleNetworkMap.
  ///
  /// In fr, this message translates to:
  /// **'Carte réseau'**
  String get moduleNetworkMap;

  /// No description provided for @moduleAr.
  ///
  /// In fr, this message translates to:
  /// **'Réalité augmentée'**
  String get moduleAr;

  /// No description provided for @moduleHse.
  ///
  /// In fr, this message translates to:
  /// **'Risques HSE'**
  String get moduleHse;

  /// No description provided for @moduleHistory.
  ///
  /// In fr, this message translates to:
  /// **'Historique'**
  String get moduleHistory;

  /// No description provided for @moduleReports.
  ///
  /// In fr, this message translates to:
  /// **'Rapports PDF'**
  String get moduleReports;

  /// No description provided for @availableInPhase.
  ///
  /// In fr, this message translates to:
  /// **'Phase {phase}'**
  String availableInPhase(int phase);

  /// No description provided for @moduleNotYetAvailable.
  ///
  /// In fr, this message translates to:
  /// **'Module prévu en phase {phase} — pas encore disponible'**
  String moduleNotYetAvailable(int phase);

  /// No description provided for @recentActivities.
  ///
  /// In fr, this message translates to:
  /// **'Activités récentes'**
  String get recentActivities;

  /// No description provided for @noActivities.
  ///
  /// In fr, this message translates to:
  /// **'Aucune activité enregistrée'**
  String get noActivities;

  /// No description provided for @noActivitiesHint.
  ///
  /// In fr, this message translates to:
  /// **'Les inspections et sessions de scan apparaîtront ici.'**
  String get noActivitiesHint;

  /// No description provided for @activityInspection.
  ///
  /// In fr, this message translates to:
  /// **'Inspection'**
  String get activityInspection;

  /// No description provided for @activityScanSession.
  ///
  /// In fr, this message translates to:
  /// **'Session de scan'**
  String get activityScanSession;

  /// No description provided for @activityRiskZone.
  ///
  /// In fr, this message translates to:
  /// **'Zone à risque'**
  String get activityRiskZone;

  /// No description provided for @activityNetwork.
  ///
  /// In fr, this message translates to:
  /// **'Réseau'**
  String get activityNetwork;

  /// No description provided for @activityReport.
  ///
  /// In fr, this message translates to:
  /// **'Rapport'**
  String get activityReport;

  /// No description provided for @loadError.
  ///
  /// In fr, this message translates to:
  /// **'Impossible de charger les données.'**
  String get loadError;

  /// No description provided for @retry.
  ///
  /// In fr, this message translates to:
  /// **'Réessayer'**
  String get retry;

  /// No description provided for @settingsTitle.
  ///
  /// In fr, this message translates to:
  /// **'Paramètres'**
  String get settingsTitle;

  /// No description provided for @account.
  ///
  /// In fr, this message translates to:
  /// **'Compte'**
  String get account;

  /// No description provided for @language.
  ///
  /// In fr, this message translates to:
  /// **'Langue'**
  String get language;

  /// No description provided for @languageFrench.
  ///
  /// In fr, this message translates to:
  /// **'Français'**
  String get languageFrench;

  /// No description provided for @languageArabic.
  ///
  /// In fr, this message translates to:
  /// **'العربية'**
  String get languageArabic;

  /// No description provided for @theme.
  ///
  /// In fr, this message translates to:
  /// **'Thème'**
  String get theme;

  /// No description provided for @themeSystem.
  ///
  /// In fr, this message translates to:
  /// **'Système'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In fr, this message translates to:
  /// **'Clair'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In fr, this message translates to:
  /// **'Sombre'**
  String get themeDark;

  /// No description provided for @demoData.
  ///
  /// In fr, this message translates to:
  /// **'Données de démonstration'**
  String get demoData;

  /// No description provided for @demoDataDescription.
  ///
  /// In fr, this message translates to:
  /// **'Afficher un jeu de données fictif, clairement marqué DÉMO, pour présenter l\'application.'**
  String get demoDataDescription;

  /// No description provided for @about.
  ///
  /// In fr, this message translates to:
  /// **'À propos'**
  String get about;

  /// No description provided for @version.
  ///
  /// In fr, this message translates to:
  /// **'Version {version}'**
  String version(String version);

  /// No description provided for @signOut.
  ///
  /// In fr, this message translates to:
  /// **'Se déconnecter'**
  String get signOut;

  /// No description provided for @signOutConfirm.
  ///
  /// In fr, this message translates to:
  /// **'Voulez-vous vraiment vous déconnecter ?'**
  String get signOutConfirm;

  /// No description provided for @cancel.
  ///
  /// In fr, this message translates to:
  /// **'Annuler'**
  String get cancel;
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
      <String>['ar', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
