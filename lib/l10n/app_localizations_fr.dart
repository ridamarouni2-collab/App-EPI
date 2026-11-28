// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appName => 'UNDERGROUND SCAN AI';

  @override
  String get appTagline => 'Investigation des réseaux enterrés & gestion HSE';

  @override
  String get splashLoading => 'Initialisation…';

  @override
  String get loginTitle => 'Connexion';

  @override
  String get loginSubtitle => 'Accédez à votre espace d\'inspection';

  @override
  String get emailLabel => 'Adresse e-mail';

  @override
  String get passwordLabel => 'Mot de passe';

  @override
  String get signIn => 'Se connecter';

  @override
  String get forgotPassword => 'Mot de passe oublié ?';

  @override
  String get showPassword => 'Afficher le mot de passe';

  @override
  String get hidePassword => 'Masquer le mot de passe';

  @override
  String get emailRequired => 'L\'adresse e-mail est obligatoire';

  @override
  String get emailInvalid => 'Adresse e-mail invalide';

  @override
  String get passwordRequired => 'Le mot de passe est obligatoire';

  @override
  String passwordTooShort(int count) {
    return 'Au moins $count caractères';
  }

  @override
  String get errorInvalidCredentials => 'E-mail ou mot de passe incorrect';

  @override
  String get errorUnavailableInDemo =>
      'Fonction indisponible en mode démonstration : elle nécessite Firebase (phase 2).';

  @override
  String get errorNetwork => 'Erreur réseau. Vérifiez votre connexion.';

  @override
  String get errorUnknown => 'Une erreur inattendue s\'est produite.';

  @override
  String get demoModeTitle => 'Mode démonstration local';

  @override
  String demoModeBody(String password) {
    return 'Firebase n\'est pas encore configuré (phase 2). La connexion utilise des comptes de démonstration stockés localement. Mot de passe commun : $password';
  }

  @override
  String get demoAccountsTitle => 'Comptes de démonstration';

  @override
  String get useThisAccount => 'Utiliser ce compte';

  @override
  String get forgotPasswordTitle => 'Réinitialiser le mot de passe';

  @override
  String get forgotPasswordBody =>
      'Saisissez votre adresse e-mail. Un lien de réinitialisation vous sera envoyé.';

  @override
  String get sendResetLink => 'Envoyer le lien';

  @override
  String resetLinkSent(String email) {
    return 'Si un compte existe pour $email, un lien de réinitialisation a été envoyé.';
  }

  @override
  String get backToLogin => 'Retour à la connexion';

  @override
  String get roleAdministrator => 'Administrateur';

  @override
  String get roleMaintenance => 'Maintenance';

  @override
  String get roleHse => 'HSE';

  @override
  String get roleInspector => 'Inspecteur';

  @override
  String get dashboardTitle => 'Tableau de bord';

  @override
  String greeting(String name) {
    return 'Bonjour, $name';
  }

  @override
  String get dashboardSubtitle =>
      'Synthèse des inspections de réseaux enterrés';

  @override
  String get hseWarning =>
      'AVERTISSEMENT : Réseau enterré possible. Ne pas percer avant vérification et autorisation.';

  @override
  String get demoDataBanner =>
      'Données de démonstration affichées : elles ne correspondent à aucune inspection réelle.';

  @override
  String get demoBadge => 'DÉMO';

  @override
  String get keyIndicators => 'Indicateurs clés';

  @override
  String get statInspections => 'Inspections';

  @override
  String get statScanSessions => 'Sessions de scan';

  @override
  String get statSuspectedLocations => 'Emplacements suspectés';

  @override
  String get statSuspectedHint => 'Hypothèses non confirmées';

  @override
  String get statVerifiedNetworks => 'Réseaux vérifiés';

  @override
  String get statVerifiedHint => 'Vérification physique';

  @override
  String get statOpenRiskZones => 'Zones à risque ouvertes';

  @override
  String get evidenceLevels => 'Niveaux de preuve';

  @override
  String get evidenceLevelsHint =>
      'Un smartphone ne voit pas à travers le béton. Chaque information est classée selon sa source.';

  @override
  String get statusSuspected => 'Suspecté';

  @override
  String get statusDocumented => 'Documenté';

  @override
  String get statusPhysicallyVerified => 'Vérifié physiquement';

  @override
  String get statusRejected => 'Rejeté';

  @override
  String get modules => 'Modules';

  @override
  String get moduleScanner => 'Scanner';

  @override
  String get moduleAiAnalysis => 'Analyse IA';

  @override
  String get moduleNetworkMap => 'Carte réseau';

  @override
  String get moduleAr => 'Réalité augmentée';

  @override
  String get moduleHse => 'Risques HSE';

  @override
  String get moduleHistory => 'Historique';

  @override
  String get moduleReports => 'Rapports PDF';

  @override
  String availableInPhase(int phase) {
    return 'Phase $phase';
  }

  @override
  String moduleNotYetAvailable(int phase) {
    return 'Module prévu en phase $phase — pas encore disponible';
  }

  @override
  String get recentActivities => 'Activités récentes';

  @override
  String get noActivities => 'Aucune activité enregistrée';

  @override
  String get noActivitiesHint =>
      'Les inspections et sessions de scan apparaîtront ici.';

  @override
  String get activityInspection => 'Inspection';

  @override
  String get activityScanSession => 'Session de scan';

  @override
  String get activityRiskZone => 'Zone à risque';

  @override
  String get activityNetwork => 'Réseau';

  @override
  String get activityReport => 'Rapport';

  @override
  String get loadError => 'Impossible de charger les données.';

  @override
  String get retry => 'Réessayer';

  @override
  String get settingsTitle => 'Paramètres';

  @override
  String get account => 'Compte';

  @override
  String get language => 'Langue';

  @override
  String get languageFrench => 'Français';

  @override
  String get languageArabic => 'العربية';

  @override
  String get theme => 'Thème';

  @override
  String get themeSystem => 'Système';

  @override
  String get themeLight => 'Clair';

  @override
  String get themeDark => 'Sombre';

  @override
  String get demoData => 'Données de démonstration';

  @override
  String get demoDataDescription =>
      'Afficher un jeu de données fictif, clairement marqué DÉMO, pour présenter l\'application.';

  @override
  String get about => 'À propos';

  @override
  String version(String version) {
    return 'Version $version';
  }

  @override
  String get signOut => 'Se déconnecter';

  @override
  String get signOutConfirm => 'Voulez-vous vraiment vous déconnecter ?';

  @override
  String get cancel => 'Annuler';
}
