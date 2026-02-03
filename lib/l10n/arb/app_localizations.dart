import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
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
/// import 'arb/app_localizations.dart';
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
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In ar, this message translates to:
  /// **'كويك نوت'**
  String get appTitle;

  /// No description provided for @notes.
  ///
  /// In ar, this message translates to:
  /// **'الملاحظات'**
  String get notes;

  /// No description provided for @createNote.
  ///
  /// In ar, this message translates to:
  /// **'إنشاء ملاحظة'**
  String get createNote;

  /// No description provided for @editNote.
  ///
  /// In ar, this message translates to:
  /// **'تعديل الملاحظة'**
  String get editNote;

  /// No description provided for @deleteNote.
  ///
  /// In ar, this message translates to:
  /// **'حذف الملاحظة'**
  String get deleteNote;

  /// No description provided for @shareNote.
  ///
  /// In ar, this message translates to:
  /// **'مشاركة الملاحظة'**
  String get shareNote;

  /// No description provided for @addToFavorites.
  ///
  /// In ar, this message translates to:
  /// **'إضافة إلى المفضلات'**
  String get addToFavorites;

  /// No description provided for @removeFromFavorites.
  ///
  /// In ar, this message translates to:
  /// **'إزالة من المفضلات'**
  String get removeFromFavorites;

  /// No description provided for @title.
  ///
  /// In ar, this message translates to:
  /// **'العنوان'**
  String get title;

  /// No description provided for @startWriting.
  ///
  /// In ar, this message translates to:
  /// **'ابدأ الكتابة هنا...'**
  String get startWriting;

  /// No description provided for @chooseColor.
  ///
  /// In ar, this message translates to:
  /// **'اختر لوناً'**
  String get chooseColor;

  /// No description provided for @done.
  ///
  /// In ar, this message translates to:
  /// **'تم'**
  String get done;

  /// No description provided for @scheduleNotification.
  ///
  /// In ar, this message translates to:
  /// **'جدولة إشعار'**
  String get scheduleNotification;

  /// No description provided for @chooseTime.
  ///
  /// In ar, this message translates to:
  /// **'اختر الوقت'**
  String get chooseTime;

  /// No description provided for @continueText.
  ///
  /// In ar, this message translates to:
  /// **'متابعة'**
  String get continueText;

  /// No description provided for @cancel.
  ///
  /// In ar, this message translates to:
  /// **'إلغاء'**
  String get cancel;

  /// No description provided for @confirm.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد'**
  String get confirm;

  /// No description provided for @notificationAlreadyExists.
  ///
  /// In ar, this message translates to:
  /// **'الملاحظة لديها إشعار بالفعل'**
  String get notificationAlreadyExists;

  /// No description provided for @editNotification.
  ///
  /// In ar, this message translates to:
  /// **'تعديل الإشعار'**
  String get editNotification;

  /// No description provided for @updateNotification.
  ///
  /// In ar, this message translates to:
  /// **'تحديث الإشعار'**
  String get updateNotification;

  /// No description provided for @newNotification.
  ///
  /// In ar, this message translates to:
  /// **'إشعار جديد'**
  String get newNotification;

  /// No description provided for @notifications.
  ///
  /// In ar, this message translates to:
  /// **'الإشعارات'**
  String get notifications;

  /// No description provided for @newNote.
  ///
  /// In ar, this message translates to:
  /// **'ملاحظة جديدة'**
  String get newNote;

  /// No description provided for @favorites.
  ///
  /// In ar, this message translates to:
  /// **'المفضلات'**
  String get favorites;

  /// No description provided for @trash.
  ///
  /// In ar, this message translates to:
  /// **'سلة المحذوفات'**
  String get trash;

  /// No description provided for @settings.
  ///
  /// In ar, this message translates to:
  /// **'الإعدادات'**
  String get settings;

  /// No description provided for @helpSupport.
  ///
  /// In ar, this message translates to:
  /// **'المساعدة والدعم'**
  String get helpSupport;

  /// No description provided for @darkMode.
  ///
  /// In ar, this message translates to:
  /// **'الوضع الداكن'**
  String get darkMode;

  /// No description provided for @lightMode.
  ///
  /// In ar, this message translates to:
  /// **'الوضع الفاتح'**
  String get lightMode;

  /// No description provided for @systemDefault.
  ///
  /// In ar, this message translates to:
  /// **'الوضع الافتراضي'**
  String get systemDefault;

  /// No description provided for @clearFavorites.
  ///
  /// In ar, this message translates to:
  /// **'تفريغ المفضلات'**
  String get clearFavorites;

  /// No description provided for @clearTrash.
  ///
  /// In ar, this message translates to:
  /// **'تفريغ سلة المحذوفات'**
  String get clearTrash;

  /// No description provided for @deleteAllNotifications.
  ///
  /// In ar, this message translates to:
  /// **'حذف جميع الإشعارات'**
  String get deleteAllNotifications;

  /// No description provided for @areYouSureClearFavorites.
  ///
  /// In ar, this message translates to:
  /// **'هل أنت متأكد من تفريغ المفضلات؟'**
  String get areYouSureClearFavorites;

  /// No description provided for @areYouSureClearTrash.
  ///
  /// In ar, this message translates to:
  /// **'هل أنت متأكد من تفريغ سلة المحذوفات؟'**
  String get areYouSureClearTrash;

  /// No description provided for @areYouSureDeleteNotifications.
  ///
  /// In ar, this message translates to:
  /// **'هل أنت متأكد من حذف جميع الإشعارات؟'**
  String get areYouSureDeleteNotifications;

  /// No description provided for @restore.
  ///
  /// In ar, this message translates to:
  /// **'استعادة'**
  String get restore;

  /// No description provided for @empty.
  ///
  /// In ar, this message translates to:
  /// **'تفريغ'**
  String get empty;

  /// No description provided for @searchNotes.
  ///
  /// In ar, this message translates to:
  /// **'ابحث في الملاحظات...'**
  String get searchNotes;

  /// No description provided for @searchHint.
  ///
  /// In ar, this message translates to:
  /// **'بحث في الملاحظات'**
  String get searchHint;

  /// No description provided for @noNotes.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد ملاحظات بعد'**
  String get noNotes;

  /// No description provided for @noFavorites.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد ملاحظات في المفضلات'**
  String get noFavorites;

  /// No description provided for @trashEmpty.
  ///
  /// In ar, this message translates to:
  /// **'سلة المحذوفات فارغة'**
  String get trashEmpty;

  /// No description provided for @save.
  ///
  /// In ar, this message translates to:
  /// **'حفظ'**
  String get save;

  /// No description provided for @update.
  ///
  /// In ar, this message translates to:
  /// **'تحديث'**
  String get update;

  /// No description provided for @delete.
  ///
  /// In ar, this message translates to:
  /// **'حذف'**
  String get delete;

  /// No description provided for @share.
  ///
  /// In ar, this message translates to:
  /// **'مشاركة'**
  String get share;

  /// No description provided for @favorite.
  ///
  /// In ar, this message translates to:
  /// **'تفضيل'**
  String get favorite;

  /// No description provided for @unfavorite.
  ///
  /// In ar, this message translates to:
  /// **'إلغاء التفضيل'**
  String get unfavorite;

  /// No description provided for @color.
  ///
  /// In ar, this message translates to:
  /// **'اللون'**
  String get color;

  /// No description provided for @reminder.
  ///
  /// In ar, this message translates to:
  /// **'تذكير'**
  String get reminder;

  /// No description provided for @noReminder.
  ///
  /// In ar, this message translates to:
  /// **'لا يوجد تذكير'**
  String get noReminder;

  /// No description provided for @scheduledFor.
  ///
  /// In ar, this message translates to:
  /// **'مجدول لـ'**
  String get scheduledFor;

  /// No description provided for @createdOn.
  ///
  /// In ar, this message translates to:
  /// **'تم الإنشاء في'**
  String get createdOn;

  /// No description provided for @editedOn.
  ///
  /// In ar, this message translates to:
  /// **'تم التعديل في'**
  String get editedOn;

  /// No description provided for @moveToTrash.
  ///
  /// In ar, this message translates to:
  /// **'نقل إلى سلة المحذوفات'**
  String get moveToTrash;

  /// No description provided for @permanentlyDelete.
  ///
  /// In ar, this message translates to:
  /// **'حذف نهائي'**
  String get permanentlyDelete;

  /// No description provided for @emptyTrash.
  ///
  /// In ar, this message translates to:
  /// **'تفريغ السلة'**
  String get emptyTrash;

  /// No description provided for @restoreNote.
  ///
  /// In ar, this message translates to:
  /// **'استعادة الملاحظة'**
  String get restoreNote;

  /// No description provided for @back.
  ///
  /// In ar, this message translates to:
  /// **'رجوع'**
  String get back;

  /// No description provided for @next.
  ///
  /// In ar, this message translates to:
  /// **'التالي'**
  String get next;

  /// No description provided for @skip.
  ///
  /// In ar, this message translates to:
  /// **'تخطي'**
  String get skip;

  /// No description provided for @getStarted.
  ///
  /// In ar, this message translates to:
  /// **'ابدأ الآن'**
  String get getStarted;

  /// No description provided for @onboarding1Title.
  ///
  /// In ar, this message translates to:
  /// **'اكتب فكرتك في ثوانٍ'**
  String get onboarding1Title;

  /// No description provided for @onboarding1Description.
  ///
  /// In ar, this message translates to:
  /// **'سجل ملاحظاتك بسرعة وسهولة - لا تترك فكرة تذهب'**
  String get onboarding1Description;

  /// No description provided for @onboarding2Title.
  ///
  /// In ar, this message translates to:
  /// **'لون ونظم كما تحب'**
  String get onboarding2Title;

  /// No description provided for @onboarding2Description.
  ///
  /// In ar, this message translates to:
  /// **'صنف ملاحظاتك بالألوان وأضفها للمفضلة لتبقى منظمًا'**
  String get onboarding2Description;

  /// No description provided for @onboarding3Title.
  ///
  /// In ar, this message translates to:
  /// **'لا تنسَ ما يهمك'**
  String get onboarding3Title;

  /// No description provided for @onboarding3Description.
  ///
  /// In ar, this message translates to:
  /// **'جدول تنبيهات للملاحظات المهمة وكن دائمًا على علم'**
  String get onboarding3Description;

  /// No description provided for @onboardingButton.
  ///
  /// In ar, this message translates to:
  /// **'أبد في تنظيم أفكارك'**
  String get onboardingButton;

  /// No description provided for @searchInNotes.
  ///
  /// In ar, this message translates to:
  /// **'بحث في الملاحظات'**
  String get searchInNotes;

  /// No description provided for @toggleDarkMode.
  ///
  /// In ar, this message translates to:
  /// **'تبديل بين الوضع الداكن والفاتح'**
  String get toggleDarkMode;

  /// No description provided for @enableNotifications.
  ///
  /// In ar, this message translates to:
  /// **'تفعيل الإشعارات'**
  String get enableNotifications;

  /// No description provided for @disableNotifications.
  ///
  /// In ar, this message translates to:
  /// **'إيقاف الإشعارات'**
  String get disableNotifications;

  /// No description provided for @notificationsToggle.
  ///
  /// In ar, this message translates to:
  /// **'ايقاف و تفعيل الاشعارات'**
  String get notificationsToggle;

  /// No description provided for @emptyStateTitle.
  ///
  /// In ar, this message translates to:
  /// **'ابدأ رحلتك التنظيمية'**
  String get emptyStateTitle;

  /// No description provided for @emptyStateDescription.
  ///
  /// In ar, this message translates to:
  /// **'أنشئ ملاحظتك الأولى لتجربة سهولة حفظ أفكارك.'**
  String get emptyStateDescription;

  /// No description provided for @welcomeMessage.
  ///
  /// In ar, this message translates to:
  /// **'مرحباً بك في كويك نوت'**
  String get welcomeMessage;

  /// No description provided for @today.
  ///
  /// In ar, this message translates to:
  /// **'اليوم'**
  String get today;

  /// No description provided for @yesterday.
  ///
  /// In ar, this message translates to:
  /// **'أمس'**
  String get yesterday;

  /// No description provided for @thisWeek.
  ///
  /// In ar, this message translates to:
  /// **'هذا الأسبوع'**
  String get thisWeek;

  /// No description provided for @older.
  ///
  /// In ar, this message translates to:
  /// **'أقدم'**
  String get older;

  /// No description provided for @noteSaved.
  ///
  /// In ar, this message translates to:
  /// **'تم حفظ الملاحظة'**
  String get noteSaved;

  /// No description provided for @noteUpdated.
  ///
  /// In ar, this message translates to:
  /// **'تم تحديث الملاحظة'**
  String get noteUpdated;

  /// No description provided for @noteDeleted.
  ///
  /// In ar, this message translates to:
  /// **'تم حذف الملاحظة'**
  String get noteDeleted;

  /// No description provided for @noteRestored.
  ///
  /// In ar, this message translates to:
  /// **'تم استعادة الملاحظة'**
  String get noteRestored;

  /// No description provided for @noteFavorited.
  ///
  /// In ar, this message translates to:
  /// **'تمت الإضافة إلى المفضلات'**
  String get noteFavorited;

  /// No description provided for @noteUnfavorited.
  ///
  /// In ar, this message translates to:
  /// **'تمت الإزالة من المفضلات'**
  String get noteUnfavorited;

  /// No description provided for @notificationScheduled.
  ///
  /// In ar, this message translates to:
  /// **'تم جدولة الإشعار'**
  String get notificationScheduled;

  /// No description provided for @notificationUpdated.
  ///
  /// In ar, this message translates to:
  /// **'تم تحديث الإشعار'**
  String get notificationUpdated;

  /// No description provided for @notificationDeleted.
  ///
  /// In ar, this message translates to:
  /// **'تم حذف الإشعار'**
  String get notificationDeleted;

  /// No description provided for @allCleared.
  ///
  /// In ar, this message translates to:
  /// **'تم التفريغ بنجاح'**
  String get allCleared;

  /// No description provided for @trashEmptied.
  ///
  /// In ar, this message translates to:
  /// **'تم تفريغ سلة المحذوفات'**
  String get trashEmptied;

  /// No description provided for @favoritesCleared.
  ///
  /// In ar, this message translates to:
  /// **'تم تفريغ المفضلات'**
  String get favoritesCleared;

  /// No description provided for @errorSaving.
  ///
  /// In ar, this message translates to:
  /// **'خطأ في الحفظ'**
  String get errorSaving;

  /// No description provided for @errorLoading.
  ///
  /// In ar, this message translates to:
  /// **'خطأ في التحميل'**
  String get errorLoading;

  /// No description provided for @tryAgain.
  ///
  /// In ar, this message translates to:
  /// **'حاول مرة أخرى'**
  String get tryAgain;

  /// No description provided for @privacyNote.
  ///
  /// In ar, this message translates to:
  /// **'ملاحظاتك تبقى على جهازك فقط'**
  String get privacyNote;

  /// No description provided for @noInternetRequired.
  ///
  /// In ar, this message translates to:
  /// **'لا يتطلب اتصال إنترنت'**
  String get noInternetRequired;

  /// No description provided for @freeForever.
  ///
  /// In ar, this message translates to:
  /// **'مجاني للأبد'**
  String get freeForever;

  /// No description provided for @notificationsDisabled.
  ///
  /// In ar, this message translates to:
  /// **'الإشعارات غير مفعلة'**
  String get notificationsDisabled;

  /// No description provided for @enableFromSettings.
  ///
  /// In ar, this message translates to:
  /// **'قم بتفعيلها من الإعدادات ثم أعد محاولة إضافة تذكير'**
  String get enableFromSettings;

  /// No description provided for @enable.
  ///
  /// In ar, this message translates to:
  /// **'تمكين'**
  String get enable;

  /// No description provided for @success.
  ///
  /// In ar, this message translates to:
  /// **'نجاح'**
  String get success;

  /// No description provided for @notificationsEnabledSuccess.
  ///
  /// In ar, this message translates to:
  /// **'تم تفعيل الاشعارات'**
  String get notificationsEnabledSuccess;

  /// No description provided for @failed.
  ///
  /// In ar, this message translates to:
  /// **'فشل'**
  String get failed;

  /// No description provided for @addNotificationFailed.
  ///
  /// In ar, this message translates to:
  /// **'فشل في إضافة الاشعار'**
  String get addNotificationFailed;
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
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
