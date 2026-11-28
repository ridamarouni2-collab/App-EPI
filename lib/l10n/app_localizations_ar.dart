// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'UNDERGROUND SCAN AI';

  @override
  String get appTagline =>
      'التحقيق في الشبكات المدفونة وإدارة الصحة والسلامة والبيئة';

  @override
  String get splashLoading => 'جارٍ التهيئة…';

  @override
  String get loginTitle => 'تسجيل الدخول';

  @override
  String get loginSubtitle => 'الوصول إلى مساحة التفتيش الخاصة بك';

  @override
  String get emailLabel => 'البريد الإلكتروني';

  @override
  String get passwordLabel => 'كلمة المرور';

  @override
  String get signIn => 'تسجيل الدخول';

  @override
  String get forgotPassword => 'نسيت كلمة المرور؟';

  @override
  String get showPassword => 'إظهار كلمة المرور';

  @override
  String get hidePassword => 'إخفاء كلمة المرور';

  @override
  String get emailRequired => 'البريد الإلكتروني مطلوب';

  @override
  String get emailInvalid => 'بريد إلكتروني غير صالح';

  @override
  String get passwordRequired => 'كلمة المرور مطلوبة';

  @override
  String passwordTooShort(int count) {
    return '$count أحرف على الأقل';
  }

  @override
  String get errorInvalidCredentials =>
      'البريد الإلكتروني أو كلمة المرور غير صحيحة';

  @override
  String get errorUnavailableInDemo =>
      'هذه الميزة غير متاحة في الوضع التجريبي: تتطلب Firebase (المرحلة 2).';

  @override
  String get errorNetwork => 'خطأ في الشبكة. تحقق من اتصالك.';

  @override
  String get errorUnknown => 'حدث خطأ غير متوقع.';

  @override
  String get demoModeTitle => 'الوضع التجريبي المحلي';

  @override
  String demoModeBody(String password) {
    return 'لم يتم إعداد Firebase بعد (المرحلة 2). يستخدم تسجيل الدخول حسابات تجريبية مخزنة محليًا. كلمة المرور المشتركة: $password';
  }

  @override
  String get demoAccountsTitle => 'الحسابات التجريبية';

  @override
  String get useThisAccount => 'استخدام هذا الحساب';

  @override
  String get forgotPasswordTitle => 'إعادة تعيين كلمة المرور';

  @override
  String get forgotPasswordBody =>
      'أدخل بريدك الإلكتروني. سيتم إرسال رابط إعادة التعيين إليك.';

  @override
  String get sendResetLink => 'إرسال الرابط';

  @override
  String resetLinkSent(String email) {
    return 'إذا كان هناك حساب مرتبط بـ $email، فقد تم إرسال رابط إعادة التعيين.';
  }

  @override
  String get backToLogin => 'العودة إلى تسجيل الدخول';

  @override
  String get roleAdministrator => 'مسؤول';

  @override
  String get roleMaintenance => 'الصيانة';

  @override
  String get roleHse => 'الصحة والسلامة والبيئة';

  @override
  String get roleInspector => 'مفتش';

  @override
  String get dashboardTitle => 'لوحة التحكم';

  @override
  String greeting(String name) {
    return 'مرحبًا، $name';
  }

  @override
  String get dashboardSubtitle => 'ملخص عمليات تفتيش الشبكات المدفونة';

  @override
  String get hseWarning =>
      'تحذير: احتمال وجود شبكة مدفونة. يُمنع الحفر قبل التحقق والحصول على الإذن.';

  @override
  String get demoDataBanner =>
      'يتم عرض بيانات تجريبية: لا تتوافق مع أي عملية تفتيش حقيقية.';

  @override
  String get demoBadge => 'تجريبي';

  @override
  String get keyIndicators => 'المؤشرات الرئيسية';

  @override
  String get statInspections => 'عمليات التفتيش';

  @override
  String get statScanSessions => 'جلسات المسح';

  @override
  String get statSuspectedLocations => 'مواقع مشتبه بها';

  @override
  String get statSuspectedHint => 'فرضيات غير مؤكدة';

  @override
  String get statVerifiedNetworks => 'شبكات تم التحقق منها';

  @override
  String get statVerifiedHint => 'تحقق ميداني';

  @override
  String get statOpenRiskZones => 'مناطق خطر مفتوحة';

  @override
  String get evidenceLevels => 'مستويات الدليل';

  @override
  String get evidenceLevelsHint =>
      'لا يمكن للهاتف الذكي الرؤية عبر الخرسانة. تُصنَّف كل معلومة حسب مصدرها.';

  @override
  String get statusSuspected => 'مشتبه به';

  @override
  String get statusDocumented => 'موثق';

  @override
  String get statusPhysicallyVerified => 'تم التحقق ميدانيًا';

  @override
  String get statusRejected => 'مرفوض';

  @override
  String get modules => 'الوحدات';

  @override
  String get moduleScanner => 'الماسح';

  @override
  String get moduleAiAnalysis => 'تحليل الذكاء الاصطناعي';

  @override
  String get moduleNetworkMap => 'خريطة الشبكة';

  @override
  String get moduleAr => 'الواقع المعزز';

  @override
  String get moduleHse => 'مخاطر HSE';

  @override
  String get moduleHistory => 'السجل';

  @override
  String get moduleReports => 'تقارير PDF';

  @override
  String availableInPhase(int phase) {
    return 'المرحلة $phase';
  }

  @override
  String moduleNotYetAvailable(int phase) {
    return 'وحدة مخططة في المرحلة $phase — غير متاحة بعد';
  }

  @override
  String get recentActivities => 'الأنشطة الأخيرة';

  @override
  String get noActivities => 'لا توجد أنشطة مسجلة';

  @override
  String get noActivitiesHint => 'ستظهر هنا عمليات التفتيش وجلسات المسح.';

  @override
  String get activityInspection => 'تفتيش';

  @override
  String get activityScanSession => 'جلسة مسح';

  @override
  String get activityRiskZone => 'منطقة خطر';

  @override
  String get activityNetwork => 'شبكة';

  @override
  String get activityReport => 'تقرير';

  @override
  String get loadError => 'تعذر تحميل البيانات.';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get settingsTitle => 'الإعدادات';

  @override
  String get account => 'الحساب';

  @override
  String get language => 'اللغة';

  @override
  String get languageFrench => 'Français';

  @override
  String get languageArabic => 'العربية';

  @override
  String get theme => 'المظهر';

  @override
  String get themeSystem => 'النظام';

  @override
  String get themeLight => 'فاتح';

  @override
  String get themeDark => 'داكن';

  @override
  String get demoData => 'بيانات تجريبية';

  @override
  String get demoDataDescription =>
      'عرض مجموعة بيانات وهمية، موسومة بوضوح بأنها تجريبية، لتقديم التطبيق.';

  @override
  String get about => 'حول التطبيق';

  @override
  String version(String version) {
    return 'الإصدار $version';
  }

  @override
  String get signOut => 'تسجيل الخروج';

  @override
  String get signOutConfirm => 'هل تريد حقًا تسجيل الخروج؟';

  @override
  String get cancel => 'إلغاء';
}
