///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsTr implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsTr({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.tr,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <tr>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsTr _root = this; // ignore: unused_field

	// Translations
	@override late final _TranslationsCoreTr core = _TranslationsCoreTr._(_root);
	@override late final _TranslationsRegistrationTr registration = _TranslationsRegistrationTr._(_root);
	@override late final _TranslationsDreamEntryTr dreamEntry = _TranslationsDreamEntryTr._(_root);
	@override String get dreamDetail => 'Rüya Açıklaması';
	@override late final _TranslationsDreamFilterOptionsTr dreamFilterOptions = _TranslationsDreamFilterOptionsTr._(_root);
	@override late final _TranslationsSearchDreamsTr searchDreams = _TranslationsSearchDreamsTr._(_root);
	@override late final _TranslationsDreamHistoryTr dreamHistory = _TranslationsDreamHistoryTr._(_root);
	@override late final _TranslationsProfileTr profile = _TranslationsProfileTr._(_root);
}

// Path: core
class _TranslationsCoreTr implements TranslationsCoreEn {
	_TranslationsCoreTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get appName => 'Rüya Günlüğü';
	@override late final _TranslationsCoreModeTr mode = _TranslationsCoreModeTr._(_root);
	@override late final _TranslationsCoreErrorsTr errors = _TranslationsCoreErrorsTr._(_root);
}

// Path: registration
class _TranslationsRegistrationTr implements TranslationsRegistrationEn {
	_TranslationsRegistrationTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get welcomeText => 'Hoş Geldiniz';
	@override late final _TranslationsRegistrationEmailTr email = _TranslationsRegistrationEmailTr._(_root);
	@override late final _TranslationsRegistrationPasswordTr password = _TranslationsRegistrationPasswordTr._(_root);
	@override late final _TranslationsRegistrationConfirmPasswordTr confirmPassword = _TranslationsRegistrationConfirmPasswordTr._(_root);
	@override late final _TranslationsRegistrationSignUpTr signUp = _TranslationsRegistrationSignUpTr._(_root);
	@override late final _TranslationsRegistrationSignInTr signIn = _TranslationsRegistrationSignInTr._(_root);
	@override late final _TranslationsRegistrationSignOutTr signOut = _TranslationsRegistrationSignOutTr._(_root);
}

// Path: dreamEntry
class _TranslationsDreamEntryTr implements TranslationsDreamEntryEn {
	_TranslationsDreamEntryTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get newDream => 'Yeni Rüya';
	@override String get saveDream => 'Rüyayı Kaydet';
	@override String get dreamTitle => 'Rüya Başlığı';
	@override String get dreamTitleHint => 'Lütfen rüyanız için bir başlık girin';
	@override String get yourDream => 'Sizin Rüyanız';
	@override late final _TranslationsDreamEntryTagsTr tags = _TranslationsDreamEntryTagsTr._(_root);
	@override String get moodRating => 'Ruh Hali Değerlendirmesi';
	@override String get failedToSaveDream => 'Rüya kaydedilemedi';
	@override late final _TranslationsDreamEntryDreamDetailsTr dreamDetails = _TranslationsDreamEntryDreamDetailsTr._(_root);
	@override late final _TranslationsDreamEntryDreamFormTr dreamForm = _TranslationsDreamEntryDreamFormTr._(_root);
	@override late final _TranslationsDreamEntryInterpretationTr interpretation = _TranslationsDreamEntryInterpretationTr._(_root);
}

// Path: dreamFilterOptions
class _TranslationsDreamFilterOptionsTr implements TranslationsDreamFilterOptionsEn {
	_TranslationsDreamFilterOptionsTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get selectTag => 'Etiket Seç';
	@override String get tags => 'Etiketler';
	@override String get all => 'Tüm';
	@override String get week => 'Bu Hafta';
	@override String get month => 'Bu Ay';
	@override String get favorites => 'Favoriler';
}

// Path: searchDreams
class _TranslationsSearchDreamsTr implements TranslationsSearchDreamsEn {
	_TranslationsSearchDreamsTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get searchDreams => 'Rüyaları Ara';
	@override String get retryButton => 'Tekrar Dene';
	@override String get noResults => 'Hiç rüya bulunamadı';
	@override String get delete => 'Sil';
	@override String get undoButton => 'Geri Al';
}

// Path: dreamHistory
class _TranslationsDreamHistoryTr implements TranslationsDreamHistoryEn {
	_TranslationsDreamHistoryTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get dreamHistory => 'Rüya Günlüğü';
	@override String get noDreams => 'Kaydedilen rüya yok';
	@override String get noDreamsCaption => 'Henüz hiçbir rüya kaydetmediniz. Bugün rüyalarınızı kaydetmeye başlayın.';
}

// Path: profile
class _TranslationsProfileTr implements TranslationsProfileEn {
	_TranslationsProfileTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get profile => 'Profil';
	@override String get username => 'Kullanıcı Adı';
	@override String get profileNotFound => 'Profil bulunamadı';
	@override String get dreamStats => 'Rüya İstatistikleri';
	@override String get totalDreams => 'Toplam Rüyalar';
	@override String get weeklyDreams => 'Haftalık Rüyalar';
	@override String get completionRate => 'Tamamlama Oranı';
	@override String get settings => 'Ayarlar';
	@override String get notifications => 'Bildirimler';
	@override String get changePassword => 'Şifreyi Değiştir';
	@override String get logout => 'Çıkış Yap';
}

// Path: core.mode
class _TranslationsCoreModeTr implements TranslationsCoreModeEn {
	_TranslationsCoreModeTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get darkMode => 'Karanlık Mod';
	@override String get lightMode => 'Aydınlık Mod';
}

// Path: core.errors
class _TranslationsCoreErrorsTr implements TranslationsCoreErrorsEn {
	_TranslationsCoreErrorsTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get error => 'Hata';
	@override String get userNotFound => 'Kullanıcı bulunamadı';
	@override String get wrongPassword => 'Geçersiz şifre';
	@override String get emailAlreadyInUse => 'E-posta zaten kayıtlı';
	@override String get invalidEmail => 'Geçersiz e-posta formatı';
	@override String get weakPassword => 'Şifre çok zayıf';
	@override String get unknown => 'Bilinmeyen bir hata oluştu';
	@override String get tryAgain => 'Lütfen tekrar deneyin';
	@override String get userNotAuthenticated => 'Kullanıcı oturum açmamış';
}

// Path: registration.email
class _TranslationsRegistrationEmailTr implements TranslationsRegistrationEmailEn {
	_TranslationsRegistrationEmailTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get emailText => 'E-posta';
	@override String get emailHint => 'Lütfen e-posta adresinizi girin';
	@override String get emailValidation => 'E-posta gerekli';
	@override String get emailInvalid => 'Lütfen geçerli bir e-posta girin';
}

// Path: registration.password
class _TranslationsRegistrationPasswordTr implements TranslationsRegistrationPasswordEn {
	_TranslationsRegistrationPasswordTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get passwordText => 'Şifre';
	@override String get passwordHint => 'Lütfen şifrenizi girin';
	@override String get passwordValidation => 'Şifre gerekli';
	@override String passwordShort({required Object minPasswordSize}) => 'Şifre en az ${minPasswordSize} karakter olmalı';
	@override late final _TranslationsRegistrationPasswordChangePasswordTr changePassword = _TranslationsRegistrationPasswordChangePasswordTr._(_root);
	@override late final _TranslationsRegistrationPasswordResetPasswordTr resetPassword = _TranslationsRegistrationPasswordResetPasswordTr._(_root);
}

// Path: registration.confirmPassword
class _TranslationsRegistrationConfirmPasswordTr implements TranslationsRegistrationConfirmPasswordEn {
	_TranslationsRegistrationConfirmPasswordTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get confirmPasswordText => 'Şifreyi Onayla';
	@override String get confirmPasswordHint => 'Şifrenizi tekrar girin';
	@override String get confirmPasswordValidation => 'Şifreyi tekrar girmeniz gerekiyor';
	@override String get confirmPasswordMismatch => 'Şifreler eşleşmiyor';
}

// Path: registration.signUp
class _TranslationsRegistrationSignUpTr implements TranslationsRegistrationSignUpEn {
	_TranslationsRegistrationSignUpTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get signUpText => 'Hesap Oluştur';
	@override String get signUpCaption => 'Bugün Rüya Günlüğüne katılın';
	@override String get alreadyHaveAccount => 'Zaten bir hesabınız var mı?';
}

// Path: registration.signIn
class _TranslationsRegistrationSignInTr implements TranslationsRegistrationSignInEn {
	_TranslationsRegistrationSignInTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get signInText => 'Giriş Yap';
	@override String get forgotPassword => 'Şifrenizi mi unuttunuz?';
}

// Path: registration.signOut
class _TranslationsRegistrationSignOutTr implements TranslationsRegistrationSignOutEn {
	_TranslationsRegistrationSignOutTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get signOutText => 'Çıkış Yap';
}

// Path: dreamEntry.tags
class _TranslationsDreamEntryTagsTr implements TranslationsDreamEntryTagsEn {
	_TranslationsDreamEntryTagsTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get tags => 'Etiketler';
	@override String get Happiness => 'mutluluk';
	@override String get Anxiety => 'kaygı';
	@override String get Fear => 'korku';
	@override String get Joy => 'neşe';
	@override String get Anger => 'öfke';
	@override String get Confusion => 'karışıklık';
	@override String get Love => 'sevgi';
	@override String get Peace => 'barış';
	@override String get Sadness => 'üzüntü';
	@override String get Excitement => 'heyecan';
}

// Path: dreamEntry.dreamDetails
class _TranslationsDreamEntryDreamDetailsTr implements TranslationsDreamEntryDreamDetailsEn {
	_TranslationsDreamEntryDreamDetailsTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get addDetails => 'Ayrıntı Ekle';
	@override String get addTags => 'Etiketler Ekle';
	@override String get moodRating => 'Ruh Hali Değerlendirmesi';
	@override String get confirmButton => 'Onayla';
}

// Path: dreamEntry.dreamForm
class _TranslationsDreamEntryDreamFormTr implements TranslationsDreamEntryDreamFormEn {
	_TranslationsDreamEntryDreamFormTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get record => 'Rüyanızı Kaydedin';
	@override String get content => 'Rüya İçeriği';
	@override String get contentHint => 'Lütfen rüya içeriğinizi girin';
	@override String get getInterpretation => 'Yorum Al';
}

// Path: dreamEntry.interpretation
class _TranslationsDreamEntryInterpretationTr implements TranslationsDreamEntryInterpretationEn {
	_TranslationsDreamEntryInterpretationTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Rüya Yorumlaması';
	@override String get interpretationText => 'Yorumlama';
	@override String get saveButton => 'Yorumu Kaydet';
	@override String get shareButton => 'Yorumu Paylaş';
}

// Path: registration.password.changePassword
class _TranslationsRegistrationPasswordChangePasswordTr implements TranslationsRegistrationPasswordChangePasswordEn {
	_TranslationsRegistrationPasswordChangePasswordTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get changePasswordText => 'Şifreyi Değiştir';
	@override String get currentPassword => 'Mevcut Şifre';
	@override String get currentPasswordValidator => 'Lütfen mevcut şifrenizi girin';
	@override String get newPassword => 'Yeni Şifre';
	@override String get newPasswordValidator => 'Lütfen yeni şifrenizi girin';
	@override String get resetPasswordButton => 'Şifreyi Sıfırla';
	@override String get confirmNewPassword => 'Yeni Şifreyi Onayla';
	@override String get success => 'Şifre başarıyla değiştirildi';
}

// Path: registration.password.resetPassword
class _TranslationsRegistrationPasswordResetPasswordTr implements TranslationsRegistrationPasswordResetPasswordEn {
	_TranslationsRegistrationPasswordResetPasswordTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get resetPasswordText => 'Şifreyi Sıfırla';
	@override String get resetPasswordButton => 'Sıfırlama linkini gönder';
	@override String get resetPasswordCaption => 'E-posta adresinizi girin ve şifrenizi sıfırlamak için bir link gönderelim.';
	@override String get resetPasswordSuccess => 'Şifre sıfırlama e-postası gönderildi. Lütfen gelen kutunuzu kontrol edin.';
	@override String get resetPasswordError => 'Şifre sıfırlama e-postası gönderilirken hata oluştu';
	@override String get backToSignIn => 'Giriş Sayfasına Geri Dön';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsTr {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'core.appName': return 'Rüya Günlüğü';
			case 'core.mode.darkMode': return 'Karanlık Mod';
			case 'core.mode.lightMode': return 'Aydınlık Mod';
			case 'core.errors.error': return 'Hata';
			case 'core.errors.userNotFound': return 'Kullanıcı bulunamadı';
			case 'core.errors.wrongPassword': return 'Geçersiz şifre';
			case 'core.errors.emailAlreadyInUse': return 'E-posta zaten kayıtlı';
			case 'core.errors.invalidEmail': return 'Geçersiz e-posta formatı';
			case 'core.errors.weakPassword': return 'Şifre çok zayıf';
			case 'core.errors.unknown': return 'Bilinmeyen bir hata oluştu';
			case 'core.errors.tryAgain': return 'Lütfen tekrar deneyin';
			case 'core.errors.userNotAuthenticated': return 'Kullanıcı oturum açmamış';
			case 'registration.welcomeText': return 'Hoş Geldiniz';
			case 'registration.email.emailText': return 'E-posta';
			case 'registration.email.emailHint': return 'Lütfen e-posta adresinizi girin';
			case 'registration.email.emailValidation': return 'E-posta gerekli';
			case 'registration.email.emailInvalid': return 'Lütfen geçerli bir e-posta girin';
			case 'registration.password.passwordText': return 'Şifre';
			case 'registration.password.passwordHint': return 'Lütfen şifrenizi girin';
			case 'registration.password.passwordValidation': return 'Şifre gerekli';
			case 'registration.password.passwordShort': return ({required Object minPasswordSize}) => 'Şifre en az ${minPasswordSize} karakter olmalı';
			case 'registration.password.changePassword.changePasswordText': return 'Şifreyi Değiştir';
			case 'registration.password.changePassword.currentPassword': return 'Mevcut Şifre';
			case 'registration.password.changePassword.currentPasswordValidator': return 'Lütfen mevcut şifrenizi girin';
			case 'registration.password.changePassword.newPassword': return 'Yeni Şifre';
			case 'registration.password.changePassword.newPasswordValidator': return 'Lütfen yeni şifrenizi girin';
			case 'registration.password.changePassword.resetPasswordButton': return 'Şifreyi Sıfırla';
			case 'registration.password.changePassword.confirmNewPassword': return 'Yeni Şifreyi Onayla';
			case 'registration.password.changePassword.success': return 'Şifre başarıyla değiştirildi';
			case 'registration.password.resetPassword.resetPasswordText': return 'Şifreyi Sıfırla';
			case 'registration.password.resetPassword.resetPasswordButton': return 'Sıfırlama linkini gönder';
			case 'registration.password.resetPassword.resetPasswordCaption': return 'E-posta adresinizi girin ve şifrenizi sıfırlamak için bir link gönderelim.';
			case 'registration.password.resetPassword.resetPasswordSuccess': return 'Şifre sıfırlama e-postası gönderildi. Lütfen gelen kutunuzu kontrol edin.';
			case 'registration.password.resetPassword.resetPasswordError': return 'Şifre sıfırlama e-postası gönderilirken hata oluştu';
			case 'registration.password.resetPassword.backToSignIn': return 'Giriş Sayfasına Geri Dön';
			case 'registration.confirmPassword.confirmPasswordText': return 'Şifreyi Onayla';
			case 'registration.confirmPassword.confirmPasswordHint': return 'Şifrenizi tekrar girin';
			case 'registration.confirmPassword.confirmPasswordValidation': return 'Şifreyi tekrar girmeniz gerekiyor';
			case 'registration.confirmPassword.confirmPasswordMismatch': return 'Şifreler eşleşmiyor';
			case 'registration.signUp.signUpText': return 'Hesap Oluştur';
			case 'registration.signUp.signUpCaption': return 'Bugün Rüya Günlüğüne katılın';
			case 'registration.signUp.alreadyHaveAccount': return 'Zaten bir hesabınız var mı?';
			case 'registration.signIn.signInText': return 'Giriş Yap';
			case 'registration.signIn.forgotPassword': return 'Şifrenizi mi unuttunuz?';
			case 'registration.signOut.signOutText': return 'Çıkış Yap';
			case 'dreamEntry.newDream': return 'Yeni Rüya';
			case 'dreamEntry.saveDream': return 'Rüyayı Kaydet';
			case 'dreamEntry.dreamTitle': return 'Rüya Başlığı';
			case 'dreamEntry.dreamTitleHint': return 'Lütfen rüyanız için bir başlık girin';
			case 'dreamEntry.yourDream': return 'Sizin Rüyanız';
			case 'dreamEntry.tags.tags': return 'Etiketler';
			case 'dreamEntry.tags.Happiness': return 'mutluluk';
			case 'dreamEntry.tags.Anxiety': return 'kaygı';
			case 'dreamEntry.tags.Fear': return 'korku';
			case 'dreamEntry.tags.Joy': return 'neşe';
			case 'dreamEntry.tags.Anger': return 'öfke';
			case 'dreamEntry.tags.Confusion': return 'karışıklık';
			case 'dreamEntry.tags.Love': return 'sevgi';
			case 'dreamEntry.tags.Peace': return 'barış';
			case 'dreamEntry.tags.Sadness': return 'üzüntü';
			case 'dreamEntry.tags.Excitement': return 'heyecan';
			case 'dreamEntry.moodRating': return 'Ruh Hali Değerlendirmesi';
			case 'dreamEntry.failedToSaveDream': return 'Rüya kaydedilemedi';
			case 'dreamEntry.dreamDetails.addDetails': return 'Ayrıntı Ekle';
			case 'dreamEntry.dreamDetails.addTags': return 'Etiketler Ekle';
			case 'dreamEntry.dreamDetails.moodRating': return 'Ruh Hali Değerlendirmesi';
			case 'dreamEntry.dreamDetails.confirmButton': return 'Onayla';
			case 'dreamEntry.dreamForm.record': return 'Rüyanızı Kaydedin';
			case 'dreamEntry.dreamForm.content': return 'Rüya İçeriği';
			case 'dreamEntry.dreamForm.contentHint': return 'Lütfen rüya içeriğinizi girin';
			case 'dreamEntry.dreamForm.getInterpretation': return 'Yorum Al';
			case 'dreamEntry.interpretation.title': return 'Rüya Yorumlaması';
			case 'dreamEntry.interpretation.interpretationText': return 'Yorumlama';
			case 'dreamEntry.interpretation.saveButton': return 'Yorumu Kaydet';
			case 'dreamEntry.interpretation.shareButton': return 'Yorumu Paylaş';
			case 'dreamDetail': return 'Rüya Açıklaması';
			case 'dreamFilterOptions.selectTag': return 'Etiket Seç';
			case 'dreamFilterOptions.tags': return 'Etiketler';
			case 'dreamFilterOptions.all': return 'Tüm';
			case 'dreamFilterOptions.week': return 'Bu Hafta';
			case 'dreamFilterOptions.month': return 'Bu Ay';
			case 'dreamFilterOptions.favorites': return 'Favoriler';
			case 'searchDreams.searchDreams': return 'Rüyaları Ara';
			case 'searchDreams.retryButton': return 'Tekrar Dene';
			case 'searchDreams.noResults': return 'Hiç rüya bulunamadı';
			case 'searchDreams.delete': return 'Sil';
			case 'searchDreams.undoButton': return 'Geri Al';
			case 'dreamHistory.dreamHistory': return 'Rüya Günlüğü';
			case 'dreamHistory.noDreams': return 'Kaydedilen rüya yok';
			case 'dreamHistory.noDreamsCaption': return 'Henüz hiçbir rüya kaydetmediniz. Bugün rüyalarınızı kaydetmeye başlayın.';
			case 'profile.profile': return 'Profil';
			case 'profile.username': return 'Kullanıcı Adı';
			case 'profile.profileNotFound': return 'Profil bulunamadı';
			case 'profile.dreamStats': return 'Rüya İstatistikleri';
			case 'profile.totalDreams': return 'Toplam Rüyalar';
			case 'profile.weeklyDreams': return 'Haftalık Rüyalar';
			case 'profile.completionRate': return 'Tamamlama Oranı';
			case 'profile.settings': return 'Ayarlar';
			case 'profile.notifications': return 'Bildirimler';
			case 'profile.changePassword': return 'Şifreyi Değiştir';
			case 'profile.logout': return 'Çıkış Yap';
			default: return null;
		}
	}
}

