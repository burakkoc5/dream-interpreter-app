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
	@override late final _TranslationsCommonTr common = _TranslationsCommonTr._(_root);
}

// Path: core
class _TranslationsCoreTr implements TranslationsCoreEn {
	_TranslationsCoreTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get appName => 'Dreamalyze';
	@override late final _TranslationsCoreModeTr mode = _TranslationsCoreModeTr._(_root);
	@override late final _TranslationsCoreErrorsTr errors = _TranslationsCoreErrorsTr._(_root);
	@override String get success => 'Başarılı';
	@override late final _TranslationsCoreEmailVerificationTr emailVerification = _TranslationsCoreEmailVerificationTr._(_root);
	@override late final _TranslationsCoreEmailVerificationDialogTr emailVerificationDialog = _TranslationsCoreEmailVerificationDialogTr._(_root);
}

// Path: registration
class _TranslationsRegistrationTr implements TranslationsRegistrationEn {
	_TranslationsRegistrationTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get welcomeText => 'Tekrar Hoş Geldiniz';
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
	@override String get discardDream => 'Vazgeç';
	@override String get shareDream => 'Paylaş';
	@override String get dreamTitle => 'Rüya Başlığı';
	@override String get dreamTitleHint => 'Lütfen rüyanız için bir başlık girin';
	@override String get yourDream => 'Rüyanız';
	@override late final _TranslationsDreamEntryTagsTr tags = _TranslationsDreamEntryTagsTr._(_root);
	@override String get moodRating => 'Duygu Derecesi';
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
	@override String get all => 'Tümü';
	@override String get week => 'Bu Hafta';
	@override String get month => 'Bu Ay';
	@override String get favorites => 'Favoriler';
}

// Path: searchDreams
class _TranslationsSearchDreamsTr implements TranslationsSearchDreamsEn {
	_TranslationsSearchDreamsTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get searchDreams => 'Rüya Ara';
	@override String get retryButton => 'Tekrar Dene';
	@override String get noResults => 'Rüya bulunamadı';
	@override String get delete => 'Sil';
	@override String get undoButton => 'Geri Al';
	@override String get dreamDeleted => 'Rüya silindi';
	@override String get deleteConfirmation => '"{title}" rüyasını silmek istediğinizden emin misiniz?';
	@override String get deleteWarning => 'Bu işlem geri alınamaz.';
}

// Path: dreamHistory
class _TranslationsDreamHistoryTr implements TranslationsDreamHistoryEn {
	_TranslationsDreamHistoryTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get dreamHistory => 'Geçmiş Rüyalar';
	@override String get noDreams => 'Hiç rüya kaydedilmedi';
	@override String get noDreamsCaption => 'Henüz hiçbir rüya kaydetmediniz. Bugün rüyalarınızı kaydetmeye başlayın.';
}

// Path: profile
class _TranslationsProfileTr implements TranslationsProfileEn {
	_TranslationsProfileTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get profile => 'Profil';
	@override String get username => 'Kullanıcı Adı';
	@override String get email => 'E-posta';
	@override String get notifications => 'Bildirimler';
	@override String get settings => 'Ayarlar';
	@override String get logout => 'Çıkış Yap';
	@override String get changePassword => 'Şifre Değiştir';
	@override String get profileNotFound => 'Profil bulunamadı';
	@override String get closeBackgroundAnimation => 'Arka Plan Animasyonunu Kapat';
	@override String get displayNameUpdated => 'Kullanıcı adı başarıyla güncellendi';
	@override late final _TranslationsProfilePersonalizationTr personalization = _TranslationsProfilePersonalizationTr._(_root);
	@override String get dreamStats => 'Rüya İstatistikleri';
	@override String get currentStreak => 'Mevcut Seri';
	@override String get longestStreak => 'En Uzun Seri';
	@override String get totalDreams => 'Toplam Rüya';
	@override String get weeklyDreams => 'Haftalık Rüyalar';
	@override String get completionRate => 'Tamamlama Oranı';
	@override String get language => 'Dil';
	@override String get english => 'İngilizce';
	@override String get turkish => 'Türkçe';
	@override String get german => 'Almanca';
	@override late final _TranslationsProfileReminderTr reminder = _TranslationsProfileReminderTr._(_root);
	@override late final _TranslationsProfileDeleteAccountTr deleteAccount = _TranslationsProfileDeleteAccountTr._(_root);
}

// Path: common
class _TranslationsCommonTr implements TranslationsCommonEn {
	_TranslationsCommonTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get cancel => 'İptal';
	@override String get confirm => 'Onayla';
	@override String get success => 'Başarılı';
	@override String get error => 'Hata';
	@override String get loading => 'Yükleniyor...';
}

// Path: core.mode
class _TranslationsCoreModeTr implements TranslationsCoreModeEn {
	_TranslationsCoreModeTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get systemMode => 'Sistem';
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
	@override String get unknown => 'E-posta veya şifre yanlış';
	@override String get tryAgain => 'Lütfen tekrar deneyin';
	@override String get userNotAuthenticated => 'Kullanıcı doğrulanamadı';
}

// Path: core.emailVerification
class _TranslationsCoreEmailVerificationTr implements TranslationsCoreEmailVerificationEn {
	_TranslationsCoreEmailVerificationTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'E-postanızı Doğrulayın';
	@override String get message => 'E-posta adresinize bir doğrulama e-postası gönderildi. Lütfen devam etmek için e-postanızı doğrulayın.';
	@override String get continue_ => 'Yine de Devam Et';
	@override String get resend => 'E-postayı Tekrar Gönder';
	@override String get resent => 'Doğrulama e-postası tekrar gönderildi';
}

// Path: core.emailVerificationDialog
class _TranslationsCoreEmailVerificationDialogTr implements TranslationsCoreEmailVerificationDialogEn {
	_TranslationsCoreEmailVerificationDialogTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get notVerifiedTitle => 'E-posta Doğrulanmadı';
	@override String get verifyTitle => 'E-postanızı Doğrulayın';
	@override String get notVerifiedMessage => 'Lütfen giriş yapmadan önce e-postanızı doğrulayın. Doğrulama bağlantısı için gelen kutunuzu kontrol edin.';
	@override String verifyMessage({required Object email}) => '${email} adresine bir doğrulama e-postası gönderildi. Lütfen devam etmek için e-postanızı doğrulayın.';
	@override String get needVerification => 'Yeni bir doğrulama e-postasına mı ihtiyacınız var?';
	@override String get checkInbox => 'Doğrulama bağlantısı için gelen kutunuzu ve spam klasörünüzü kontrol edin.';
	@override String get cancel => 'İptal';
	@override String get resend => 'Tekrar Gönder';
	@override String get goToLogin => 'Girişe Git';
}

// Path: registration.email
class _TranslationsRegistrationEmailTr implements TranslationsRegistrationEmailEn {
	_TranslationsRegistrationEmailTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get emailText => 'E-posta';
	@override String get emailHint => 'Lütfen e-postanızı girin';
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
	@override String get confirmPasswordHint => 'Şifrenizi yeniden girin';
	@override String get confirmPasswordValidation => 'Şifreyi yeniden girmek gerekli';
	@override String get confirmPasswordMismatch => 'Şifreler uyuşmuyor';
}

// Path: registration.signUp
class _TranslationsRegistrationSignUpTr implements TranslationsRegistrationSignUpEn {
	_TranslationsRegistrationSignUpTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get signUpText => 'Hesap Oluştur';
	@override String get signUpCaption => 'Rüya Günlüğü\'ne bugün katılın';
	@override String get subtitle => 'Rüyalarınızı keşfetmek için bize katılın';
	@override String get alreadyHaveAccount => 'Zaten bir hesabınız var mı?';
}

// Path: registration.signIn
class _TranslationsRegistrationSignInTr implements TranslationsRegistrationSignInEn {
	_TranslationsRegistrationSignInTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get signInText => 'Giriş Yap';
	@override String get forgotPassword => 'Şifremi Unuttum?';
	@override String get subtitle => 'Yapay zeka ile rüyalarınızı keşfedin';
	@override String get or => 'VEYA';
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
	@override String get Confusion => 'karmaşa';
	@override String get Love => 'sevgi';
	@override String get Peace => 'huzur';
	@override String get Sadness => 'üzüntü';
	@override String get Excitement => 'heyecan';
}

// Path: dreamEntry.dreamDetails
class _TranslationsDreamEntryDreamDetailsTr implements TranslationsDreamEntryDreamDetailsEn {
	_TranslationsDreamEntryDreamDetailsTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get addDetails => 'Detay Ekle';
	@override String get addTags => 'Etiket Ekle';
	@override String get moodRating => 'Duygu Derecesi';
	@override String get confirmButton => 'Onayla';
}

// Path: dreamEntry.dreamForm
class _TranslationsDreamEntryDreamFormTr implements TranslationsDreamEntryDreamFormEn {
	_TranslationsDreamEntryDreamFormTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get record => 'Rüyanı Kaydet';
	@override String get content => 'Rüya İçeriği';
	@override String get contentHint => 'Lütfen rüyanızı girin';
	@override String get getInterpretation => 'Yorumla';
	@override String get noAttemptsLeft => 'Bugün için kalan hakkınız yok. Daha fazla rüya yorumlamak için reklam izleyin.';
	@override String get watchAdError => 'Bugün daha fazla rüya yorumlamak için lütfen reklamı izleyin.';
	@override String get watchAdForInterpretation => 'Reklam izleyerek yorum al';
	@override String get dreamSaved => 'Rüya başarıyla kaydedildi';
	@override String get remainingAttempts => 'Bugün kalan hakkınız';
}

// Path: dreamEntry.interpretation
class _TranslationsDreamEntryInterpretationTr implements TranslationsDreamEntryInterpretationEn {
	_TranslationsDreamEntryInterpretationTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Rüya Yorumu';
	@override String get interpretationText => 'Yorum';
	@override String get saveButton => 'Yorumu Kaydet';
	@override String get shareButton => 'Yorumu Paylaş';
}

// Path: profile.personalization
class _TranslationsProfilePersonalizationTr implements TranslationsProfilePersonalizationEn {
	_TranslationsProfilePersonalizationTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Profilinizi Kişiselleştirin';
	@override String get description => 'Sizi daha iyi anlayarak daha kişiselleştirilmiş rüya yorumları sunmamıza yardımcı olun.';
	@override String get gender => 'Cinsiyet';
	@override String get birthDate => 'Doğum Tarihi';
	@override String get selectBirthDate => 'Doğum Tarihini Seç';
	@override String get horoscope => 'Burç';
	@override String get occupation => 'Meslek';
	@override late final _TranslationsProfilePersonalizationOccupationOptionsTr occupationOptions = _TranslationsProfilePersonalizationOccupationOptionsTr._(_root);
	@override String get relationshipStatus => 'İlişki Durumu';
	@override String get interests => 'İlgi Alanlarınız';
	@override String get submit => 'Kaydet ve Devam Et';
	@override late final _TranslationsProfilePersonalizationGenderOptionsTr genderOptions = _TranslationsProfilePersonalizationGenderOptionsTr._(_root);
	@override late final _TranslationsProfilePersonalizationHoroscopeOptionsTr horoscopeOptions = _TranslationsProfilePersonalizationHoroscopeOptionsTr._(_root);
	@override late final _TranslationsProfilePersonalizationRelationshipOptionsTr relationshipOptions = _TranslationsProfilePersonalizationRelationshipOptionsTr._(_root);
	@override late final _TranslationsProfilePersonalizationInterestOptionsTr interestOptions = _TranslationsProfilePersonalizationInterestOptionsTr._(_root);
}

// Path: profile.reminder
class _TranslationsProfileReminderTr implements TranslationsProfileReminderEn {
	_TranslationsProfileReminderTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get setTime => 'Hatırlatıcı ayarla';
	@override String get chooseTime => 'Hatırlatılmak istediğiniz zamanı seçin';
	@override String get description => 'Rüyalarınızı hatırlamanız için size bir bildirim göndereceğiz';
	@override String get earlyMorning => 'Sabah';
	@override String get earlyMorningTime => '6:00 AM';
	@override String get afternoon => 'Öğleden sonra';
	@override String get afternoonTime => '2:00 PM';
	@override String get nighttime => 'Gece';
	@override String get nighttimeTime => '10:00 PM';
	@override String get custom => 'Özel';
	@override String get setCustomTime => 'Zamanınızı ayarlayın';
	@override String get saveButton => 'Hatırlatmayı Kaydet';
	@override String get skipButton => 'Şimdilik Vazgeç';
	@override String get savedSuccess => 'Hatırlatma ayarları başarıyla kaydedildi';
}

// Path: profile.deleteAccount
class _TranslationsProfileDeleteAccountTr implements TranslationsProfileDeleteAccountEn {
	_TranslationsProfileDeleteAccountTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Hesabınızı Sil';
	@override String get message => 'Hesabınızı silmek istediğinizden emin misiniz? Bu işlem geri alınamaz ve tüm verilerinizi (rüyalar, yorumlar ve ayarlar dahil) kalıcı olarak silecektir.';
	@override String get warning => 'Bu işlem geri alınamaz ve tüm verilerinizi (rüyalar, yorumlar ve ayarlar dahil) kalıcı olarak silecektir.';
	@override String get confirm => 'Evet, Sil';
}

// Path: registration.password.changePassword
class _TranslationsRegistrationPasswordChangePasswordTr implements TranslationsRegistrationPasswordChangePasswordEn {
	_TranslationsRegistrationPasswordChangePasswordTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get changePasswordText => 'Şifre Değiştir';
	@override String get currentPassword => 'Mevcut Şifre';
	@override String get currentPasswordValidator => 'Lütfen mevcut şifrenizi girin';
	@override String get newPassword => 'Yeni Şifre';
	@override String get newPasswordValidator => 'Lütfen yeni bir şifre girin';
	@override String get resetPasswordButton => 'Şifreyi Sıfırla';
	@override String get confirmNewPassword => 'Yeni Şifreyi Onayla';
	@override String get success => 'Şifre başarıyla değiştirildi';
}

// Path: registration.password.resetPassword
class _TranslationsRegistrationPasswordResetPasswordTr implements TranslationsRegistrationPasswordResetPasswordEn {
	_TranslationsRegistrationPasswordResetPasswordTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get resetPasswordText => 'Şifre Sıfırla';
	@override String get resetPasswordButton => 'Sıfırlama Bağlantısı Gönder';
	@override String get resetPasswordCaption => 'E-posta adresinizi girin, size şifre sıfırlama bağlantısını gönderelim.';
	@override String get resetPasswordSuccess => 'Şifre sıfırlama e-postası gönderildi. Lütfen gelen kutunuzu kontrol edin.';
	@override String get resetPasswordError => 'Şifre sıfırlama e-postası gönderilirken hata oluştu';
	@override String get backToSignIn => 'Girişe Geri Dön';
}

// Path: profile.personalization.occupationOptions
class _TranslationsProfilePersonalizationOccupationOptionsTr implements TranslationsProfilePersonalizationOccupationOptionsEn {
	_TranslationsProfilePersonalizationOccupationOptionsTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get homemaker => 'Ev Hanımı';
	@override String get unemployed => 'Çalışmıyor';
	@override String get jobSeeker => 'İş Arıyor';
	@override String get student => 'Öğrenci';
	@override String get academic => 'Akademisyen';
	@override String get selfEmployed => 'Kendi İşini Yapıyor';
	@override String get publicSector => 'Kamu Sektörü';
	@override String get privateSector => 'Özel Sektör';
	@override String get retired => 'Emekli';
}

// Path: profile.personalization.genderOptions
class _TranslationsProfilePersonalizationGenderOptionsTr implements TranslationsProfilePersonalizationGenderOptionsEn {
	_TranslationsProfilePersonalizationGenderOptionsTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get male => 'Erkek';
	@override String get female => 'Kadın';
	@override String get other => 'Diğer';
	@override String get preferNotToSay => 'Belirtmek istemiyorum';
}

// Path: profile.personalization.horoscopeOptions
class _TranslationsProfilePersonalizationHoroscopeOptionsTr implements TranslationsProfilePersonalizationHoroscopeOptionsEn {
	_TranslationsProfilePersonalizationHoroscopeOptionsTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get aries => 'Koç';
	@override String get taurus => 'Boğa';
	@override String get gemini => 'İkizler';
	@override String get cancer => 'Yengeç';
	@override String get leo => 'Aslan';
	@override String get virgo => 'Başak';
	@override String get libra => 'Terazi';
	@override String get scorpio => 'Akrep';
	@override String get sagittarius => 'Yay';
	@override String get capricorn => 'Oğlak';
	@override String get aquarius => 'Kova';
	@override String get pisces => 'Balık';
}

// Path: profile.personalization.relationshipOptions
class _TranslationsProfilePersonalizationRelationshipOptionsTr implements TranslationsProfilePersonalizationRelationshipOptionsEn {
	_TranslationsProfilePersonalizationRelationshipOptionsTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get single => 'Bekar';
	@override String get inRelationship => 'Bir ilişkide';
	@override String get married => 'Evli';
	@override String get preferNotToSay => 'Belirtmek istemiyorum';
}

// Path: profile.personalization.interestOptions
class _TranslationsProfilePersonalizationInterestOptionsTr implements TranslationsProfilePersonalizationInterestOptionsEn {
	_TranslationsProfilePersonalizationInterestOptionsTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get spirituality => 'Spiritüellik';
	@override String get meditation => 'Meditasyon';
	@override String get psychology => 'Psikoloji';
	@override String get selfImprovement => 'Kişisel Gelişim';
	@override String get art => 'Sanat';
	@override String get music => 'Müzik';
	@override String get travel => 'Seyahat';
	@override String get nature => 'Doğa';
	@override String get technology => 'Teknoloji';
	@override String get science => 'Bilim';
	@override String get sports => 'Spor';
	@override String get cooking => 'Yemek Pişirme';
	@override String get reading => 'Okuma';
	@override String get writing => 'Yazma';
	@override String get photography => 'Fotoğrafçılık';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsTr {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'core.appName': return 'Dreamalyze';
			case 'core.mode.systemMode': return 'Sistem';
			case 'core.mode.darkMode': return 'Karanlık Mod';
			case 'core.mode.lightMode': return 'Aydınlık Mod';
			case 'core.errors.error': return 'Hata';
			case 'core.errors.userNotFound': return 'Kullanıcı bulunamadı';
			case 'core.errors.wrongPassword': return 'Geçersiz şifre';
			case 'core.errors.emailAlreadyInUse': return 'E-posta zaten kayıtlı';
			case 'core.errors.invalidEmail': return 'Geçersiz e-posta formatı';
			case 'core.errors.weakPassword': return 'Şifre çok zayıf';
			case 'core.errors.unknown': return 'E-posta veya şifre yanlış';
			case 'core.errors.tryAgain': return 'Lütfen tekrar deneyin';
			case 'core.errors.userNotAuthenticated': return 'Kullanıcı doğrulanamadı';
			case 'core.success': return 'Başarılı';
			case 'core.emailVerification.title': return 'E-postanızı Doğrulayın';
			case 'core.emailVerification.message': return 'E-posta adresinize bir doğrulama e-postası gönderildi. Lütfen devam etmek için e-postanızı doğrulayın.';
			case 'core.emailVerification.continue_': return 'Yine de Devam Et';
			case 'core.emailVerification.resend': return 'E-postayı Tekrar Gönder';
			case 'core.emailVerification.resent': return 'Doğrulama e-postası tekrar gönderildi';
			case 'core.emailVerificationDialog.notVerifiedTitle': return 'E-posta Doğrulanmadı';
			case 'core.emailVerificationDialog.verifyTitle': return 'E-postanızı Doğrulayın';
			case 'core.emailVerificationDialog.notVerifiedMessage': return 'Lütfen giriş yapmadan önce e-postanızı doğrulayın. Doğrulama bağlantısı için gelen kutunuzu kontrol edin.';
			case 'core.emailVerificationDialog.verifyMessage': return ({required Object email}) => '${email} adresine bir doğrulama e-postası gönderildi. Lütfen devam etmek için e-postanızı doğrulayın.';
			case 'core.emailVerificationDialog.needVerification': return 'Yeni bir doğrulama e-postasına mı ihtiyacınız var?';
			case 'core.emailVerificationDialog.checkInbox': return 'Doğrulama bağlantısı için gelen kutunuzu ve spam klasörünüzü kontrol edin.';
			case 'core.emailVerificationDialog.cancel': return 'İptal';
			case 'core.emailVerificationDialog.resend': return 'Tekrar Gönder';
			case 'core.emailVerificationDialog.goToLogin': return 'Girişe Git';
			case 'registration.welcomeText': return 'Tekrar Hoş Geldiniz';
			case 'registration.email.emailText': return 'E-posta';
			case 'registration.email.emailHint': return 'Lütfen e-postanızı girin';
			case 'registration.email.emailValidation': return 'E-posta gerekli';
			case 'registration.email.emailInvalid': return 'Lütfen geçerli bir e-posta girin';
			case 'registration.password.passwordText': return 'Şifre';
			case 'registration.password.passwordHint': return 'Lütfen şifrenizi girin';
			case 'registration.password.passwordValidation': return 'Şifre gerekli';
			case 'registration.password.passwordShort': return ({required Object minPasswordSize}) => 'Şifre en az ${minPasswordSize} karakter olmalı';
			case 'registration.password.changePassword.changePasswordText': return 'Şifre Değiştir';
			case 'registration.password.changePassword.currentPassword': return 'Mevcut Şifre';
			case 'registration.password.changePassword.currentPasswordValidator': return 'Lütfen mevcut şifrenizi girin';
			case 'registration.password.changePassword.newPassword': return 'Yeni Şifre';
			case 'registration.password.changePassword.newPasswordValidator': return 'Lütfen yeni bir şifre girin';
			case 'registration.password.changePassword.resetPasswordButton': return 'Şifreyi Sıfırla';
			case 'registration.password.changePassword.confirmNewPassword': return 'Yeni Şifreyi Onayla';
			case 'registration.password.changePassword.success': return 'Şifre başarıyla değiştirildi';
			case 'registration.password.resetPassword.resetPasswordText': return 'Şifre Sıfırla';
			case 'registration.password.resetPassword.resetPasswordButton': return 'Sıfırlama Bağlantısı Gönder';
			case 'registration.password.resetPassword.resetPasswordCaption': return 'E-posta adresinizi girin, size şifre sıfırlama bağlantısını gönderelim.';
			case 'registration.password.resetPassword.resetPasswordSuccess': return 'Şifre sıfırlama e-postası gönderildi. Lütfen gelen kutunuzu kontrol edin.';
			case 'registration.password.resetPassword.resetPasswordError': return 'Şifre sıfırlama e-postası gönderilirken hata oluştu';
			case 'registration.password.resetPassword.backToSignIn': return 'Girişe Geri Dön';
			case 'registration.confirmPassword.confirmPasswordText': return 'Şifreyi Onayla';
			case 'registration.confirmPassword.confirmPasswordHint': return 'Şifrenizi yeniden girin';
			case 'registration.confirmPassword.confirmPasswordValidation': return 'Şifreyi yeniden girmek gerekli';
			case 'registration.confirmPassword.confirmPasswordMismatch': return 'Şifreler uyuşmuyor';
			case 'registration.signUp.signUpText': return 'Hesap Oluştur';
			case 'registration.signUp.signUpCaption': return 'Rüya Günlüğü\'ne bugün katılın';
			case 'registration.signUp.subtitle': return 'Rüyalarınızı keşfetmek için bize katılın';
			case 'registration.signUp.alreadyHaveAccount': return 'Zaten bir hesabınız var mı?';
			case 'registration.signIn.signInText': return 'Giriş Yap';
			case 'registration.signIn.forgotPassword': return 'Şifremi Unuttum?';
			case 'registration.signIn.subtitle': return 'Yapay zeka ile rüyalarınızı keşfedin';
			case 'registration.signIn.or': return 'VEYA';
			case 'registration.signOut.signOutText': return 'Çıkış Yap';
			case 'dreamEntry.newDream': return 'Yeni Rüya';
			case 'dreamEntry.saveDream': return 'Rüyayı Kaydet';
			case 'dreamEntry.discardDream': return 'Vazgeç';
			case 'dreamEntry.shareDream': return 'Paylaş';
			case 'dreamEntry.dreamTitle': return 'Rüya Başlığı';
			case 'dreamEntry.dreamTitleHint': return 'Lütfen rüyanız için bir başlık girin';
			case 'dreamEntry.yourDream': return 'Rüyanız';
			case 'dreamEntry.tags.tags': return 'Etiketler';
			case 'dreamEntry.tags.Happiness': return 'mutluluk';
			case 'dreamEntry.tags.Anxiety': return 'kaygı';
			case 'dreamEntry.tags.Fear': return 'korku';
			case 'dreamEntry.tags.Joy': return 'neşe';
			case 'dreamEntry.tags.Anger': return 'öfke';
			case 'dreamEntry.tags.Confusion': return 'karmaşa';
			case 'dreamEntry.tags.Love': return 'sevgi';
			case 'dreamEntry.tags.Peace': return 'huzur';
			case 'dreamEntry.tags.Sadness': return 'üzüntü';
			case 'dreamEntry.tags.Excitement': return 'heyecan';
			case 'dreamEntry.moodRating': return 'Duygu Derecesi';
			case 'dreamEntry.failedToSaveDream': return 'Rüya kaydedilemedi';
			case 'dreamEntry.dreamDetails.addDetails': return 'Detay Ekle';
			case 'dreamEntry.dreamDetails.addTags': return 'Etiket Ekle';
			case 'dreamEntry.dreamDetails.moodRating': return 'Duygu Derecesi';
			case 'dreamEntry.dreamDetails.confirmButton': return 'Onayla';
			case 'dreamEntry.dreamForm.record': return 'Rüyanı Kaydet';
			case 'dreamEntry.dreamForm.content': return 'Rüya İçeriği';
			case 'dreamEntry.dreamForm.contentHint': return 'Lütfen rüyanızı girin';
			case 'dreamEntry.dreamForm.getInterpretation': return 'Yorumla';
			case 'dreamEntry.dreamForm.noAttemptsLeft': return 'Bugün için kalan hakkınız yok. Daha fazla rüya yorumlamak için reklam izleyin.';
			case 'dreamEntry.dreamForm.watchAdError': return 'Bugün daha fazla rüya yorumlamak için lütfen reklamı izleyin.';
			case 'dreamEntry.dreamForm.watchAdForInterpretation': return 'Reklam izleyerek yorum al';
			case 'dreamEntry.dreamForm.dreamSaved': return 'Rüya başarıyla kaydedildi';
			case 'dreamEntry.dreamForm.remainingAttempts': return 'Bugün kalan hakkınız';
			case 'dreamEntry.interpretation.title': return 'Rüya Yorumu';
			case 'dreamEntry.interpretation.interpretationText': return 'Yorum';
			case 'dreamEntry.interpretation.saveButton': return 'Yorumu Kaydet';
			case 'dreamEntry.interpretation.shareButton': return 'Yorumu Paylaş';
			case 'dreamDetail': return 'Rüya Açıklaması';
			case 'dreamFilterOptions.selectTag': return 'Etiket Seç';
			case 'dreamFilterOptions.tags': return 'Etiketler';
			case 'dreamFilterOptions.all': return 'Tümü';
			case 'dreamFilterOptions.week': return 'Bu Hafta';
			case 'dreamFilterOptions.month': return 'Bu Ay';
			case 'dreamFilterOptions.favorites': return 'Favoriler';
			case 'searchDreams.searchDreams': return 'Rüya Ara';
			case 'searchDreams.retryButton': return 'Tekrar Dene';
			case 'searchDreams.noResults': return 'Rüya bulunamadı';
			case 'searchDreams.delete': return 'Sil';
			case 'searchDreams.undoButton': return 'Geri Al';
			case 'searchDreams.dreamDeleted': return 'Rüya silindi';
			case 'searchDreams.deleteConfirmation': return '"{title}" rüyasını silmek istediğinizden emin misiniz?';
			case 'searchDreams.deleteWarning': return 'Bu işlem geri alınamaz.';
			case 'dreamHistory.dreamHistory': return 'Geçmiş Rüyalar';
			case 'dreamHistory.noDreams': return 'Hiç rüya kaydedilmedi';
			case 'dreamHistory.noDreamsCaption': return 'Henüz hiçbir rüya kaydetmediniz. Bugün rüyalarınızı kaydetmeye başlayın.';
			case 'profile.profile': return 'Profil';
			case 'profile.username': return 'Kullanıcı Adı';
			case 'profile.email': return 'E-posta';
			case 'profile.notifications': return 'Bildirimler';
			case 'profile.settings': return 'Ayarlar';
			case 'profile.logout': return 'Çıkış Yap';
			case 'profile.changePassword': return 'Şifre Değiştir';
			case 'profile.profileNotFound': return 'Profil bulunamadı';
			case 'profile.closeBackgroundAnimation': return 'Arka Plan Animasyonunu Kapat';
			case 'profile.displayNameUpdated': return 'Kullanıcı adı başarıyla güncellendi';
			case 'profile.personalization.title': return 'Profilinizi Kişiselleştirin';
			case 'profile.personalization.description': return 'Sizi daha iyi anlayarak daha kişiselleştirilmiş rüya yorumları sunmamıza yardımcı olun.';
			case 'profile.personalization.gender': return 'Cinsiyet';
			case 'profile.personalization.birthDate': return 'Doğum Tarihi';
			case 'profile.personalization.selectBirthDate': return 'Doğum Tarihini Seç';
			case 'profile.personalization.horoscope': return 'Burç';
			case 'profile.personalization.occupation': return 'Meslek';
			case 'profile.personalization.occupationOptions.homemaker': return 'Ev Hanımı';
			case 'profile.personalization.occupationOptions.unemployed': return 'Çalışmıyor';
			case 'profile.personalization.occupationOptions.jobSeeker': return 'İş Arıyor';
			case 'profile.personalization.occupationOptions.student': return 'Öğrenci';
			case 'profile.personalization.occupationOptions.academic': return 'Akademisyen';
			case 'profile.personalization.occupationOptions.selfEmployed': return 'Kendi İşini Yapıyor';
			case 'profile.personalization.occupationOptions.publicSector': return 'Kamu Sektörü';
			case 'profile.personalization.occupationOptions.privateSector': return 'Özel Sektör';
			case 'profile.personalization.occupationOptions.retired': return 'Emekli';
			case 'profile.personalization.relationshipStatus': return 'İlişki Durumu';
			case 'profile.personalization.interests': return 'İlgi Alanlarınız';
			case 'profile.personalization.submit': return 'Kaydet ve Devam Et';
			case 'profile.personalization.genderOptions.male': return 'Erkek';
			case 'profile.personalization.genderOptions.female': return 'Kadın';
			case 'profile.personalization.genderOptions.other': return 'Diğer';
			case 'profile.personalization.genderOptions.preferNotToSay': return 'Belirtmek istemiyorum';
			case 'profile.personalization.horoscopeOptions.aries': return 'Koç';
			case 'profile.personalization.horoscopeOptions.taurus': return 'Boğa';
			case 'profile.personalization.horoscopeOptions.gemini': return 'İkizler';
			case 'profile.personalization.horoscopeOptions.cancer': return 'Yengeç';
			case 'profile.personalization.horoscopeOptions.leo': return 'Aslan';
			case 'profile.personalization.horoscopeOptions.virgo': return 'Başak';
			case 'profile.personalization.horoscopeOptions.libra': return 'Terazi';
			case 'profile.personalization.horoscopeOptions.scorpio': return 'Akrep';
			case 'profile.personalization.horoscopeOptions.sagittarius': return 'Yay';
			case 'profile.personalization.horoscopeOptions.capricorn': return 'Oğlak';
			case 'profile.personalization.horoscopeOptions.aquarius': return 'Kova';
			case 'profile.personalization.horoscopeOptions.pisces': return 'Balık';
			case 'profile.personalization.relationshipOptions.single': return 'Bekar';
			case 'profile.personalization.relationshipOptions.inRelationship': return 'Bir ilişkide';
			case 'profile.personalization.relationshipOptions.married': return 'Evli';
			case 'profile.personalization.relationshipOptions.preferNotToSay': return 'Belirtmek istemiyorum';
			case 'profile.personalization.interestOptions.spirituality': return 'Spiritüellik';
			case 'profile.personalization.interestOptions.meditation': return 'Meditasyon';
			case 'profile.personalization.interestOptions.psychology': return 'Psikoloji';
			case 'profile.personalization.interestOptions.selfImprovement': return 'Kişisel Gelişim';
			case 'profile.personalization.interestOptions.art': return 'Sanat';
			case 'profile.personalization.interestOptions.music': return 'Müzik';
			case 'profile.personalization.interestOptions.travel': return 'Seyahat';
			case 'profile.personalization.interestOptions.nature': return 'Doğa';
			case 'profile.personalization.interestOptions.technology': return 'Teknoloji';
			case 'profile.personalization.interestOptions.science': return 'Bilim';
			case 'profile.personalization.interestOptions.sports': return 'Spor';
			case 'profile.personalization.interestOptions.cooking': return 'Yemek Pişirme';
			case 'profile.personalization.interestOptions.reading': return 'Okuma';
			case 'profile.personalization.interestOptions.writing': return 'Yazma';
			case 'profile.personalization.interestOptions.photography': return 'Fotoğrafçılık';
			case 'profile.dreamStats': return 'Rüya İstatistikleri';
			case 'profile.currentStreak': return 'Mevcut Seri';
			case 'profile.longestStreak': return 'En Uzun Seri';
			case 'profile.totalDreams': return 'Toplam Rüya';
			case 'profile.weeklyDreams': return 'Haftalık Rüyalar';
			case 'profile.completionRate': return 'Tamamlama Oranı';
			case 'profile.language': return 'Dil';
			case 'profile.english': return 'İngilizce';
			case 'profile.turkish': return 'Türkçe';
			case 'profile.german': return 'Almanca';
			case 'profile.reminder.setTime': return 'Hatırlatıcı ayarla';
			case 'profile.reminder.chooseTime': return 'Hatırlatılmak istediğiniz zamanı seçin';
			case 'profile.reminder.description': return 'Rüyalarınızı hatırlamanız için size bir bildirim göndereceğiz';
			case 'profile.reminder.earlyMorning': return 'Sabah';
			case 'profile.reminder.earlyMorningTime': return '6:00 AM';
			case 'profile.reminder.afternoon': return 'Öğleden sonra';
			case 'profile.reminder.afternoonTime': return '2:00 PM';
			case 'profile.reminder.nighttime': return 'Gece';
			case 'profile.reminder.nighttimeTime': return '10:00 PM';
			case 'profile.reminder.custom': return 'Özel';
			case 'profile.reminder.setCustomTime': return 'Zamanınızı ayarlayın';
			case 'profile.reminder.saveButton': return 'Hatırlatmayı Kaydet';
			case 'profile.reminder.skipButton': return 'Şimdilik Vazgeç';
			case 'profile.reminder.savedSuccess': return 'Hatırlatma ayarları başarıyla kaydedildi';
			case 'profile.deleteAccount.title': return 'Hesabınızı Sil';
			case 'profile.deleteAccount.message': return 'Hesabınızı silmek istediğinizden emin misiniz? Bu işlem geri alınamaz ve tüm verilerinizi (rüyalar, yorumlar ve ayarlar dahil) kalıcı olarak silecektir.';
			case 'profile.deleteAccount.warning': return 'Bu işlem geri alınamaz ve tüm verilerinizi (rüyalar, yorumlar ve ayarlar dahil) kalıcı olarak silecektir.';
			case 'profile.deleteAccount.confirm': return 'Evet, Sil';
			case 'common.cancel': return 'İptal';
			case 'common.confirm': return 'Onayla';
			case 'common.success': return 'Başarılı';
			case 'common.error': return 'Hata';
			case 'common.loading': return 'Yükleniyor...';
			default: return null;
		}
	}
}

