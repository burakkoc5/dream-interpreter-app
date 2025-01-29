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
class TranslationsDe implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsDe({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.de,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <de>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsDe _root = this; // ignore: unused_field

	// Translations
	@override late final _TranslationsCoreDe core = _TranslationsCoreDe._(_root);
	@override late final _TranslationsRegistrationDe registration = _TranslationsRegistrationDe._(_root);
	@override late final _TranslationsDreamEntryDe dreamEntry = _TranslationsDreamEntryDe._(_root);
	@override String get dreamDetail => 'Traumbeschreibung';
	@override late final _TranslationsDreamFilterOptionsDe dreamFilterOptions = _TranslationsDreamFilterOptionsDe._(_root);
	@override late final _TranslationsSearchDreamsDe searchDreams = _TranslationsSearchDreamsDe._(_root);
	@override late final _TranslationsDreamHistoryDe dreamHistory = _TranslationsDreamHistoryDe._(_root);
	@override late final _TranslationsProfileDe profile = _TranslationsProfileDe._(_root);
	@override late final _TranslationsCommonDe common = _TranslationsCommonDe._(_root);
}

// Path: core
class _TranslationsCoreDe implements TranslationsCoreEn {
	_TranslationsCoreDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get appName => 'Dreamalyze';
	@override late final _TranslationsCoreModeDe mode = _TranslationsCoreModeDe._(_root);
	@override late final _TranslationsCoreErrorsDe errors = _TranslationsCoreErrorsDe._(_root);
	@override String get success => 'Erfolgreich';
	@override late final _TranslationsCoreEmailVerificationDe emailVerification = _TranslationsCoreEmailVerificationDe._(_root);
	@override late final _TranslationsCoreEmailVerificationDialogDe emailVerificationDialog = _TranslationsCoreEmailVerificationDialogDe._(_root);
}

// Path: registration
class _TranslationsRegistrationDe implements TranslationsRegistrationEn {
	_TranslationsRegistrationDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get welcomeText => 'Willkommen zurück';
	@override late final _TranslationsRegistrationEmailDe email = _TranslationsRegistrationEmailDe._(_root);
	@override late final _TranslationsRegistrationPasswordDe password = _TranslationsRegistrationPasswordDe._(_root);
	@override late final _TranslationsRegistrationConfirmPasswordDe confirmPassword = _TranslationsRegistrationConfirmPasswordDe._(_root);
	@override late final _TranslationsRegistrationSignUpDe signUp = _TranslationsRegistrationSignUpDe._(_root);
	@override late final _TranslationsRegistrationSignInDe signIn = _TranslationsRegistrationSignInDe._(_root);
	@override late final _TranslationsRegistrationSignOutDe signOut = _TranslationsRegistrationSignOutDe._(_root);
}

// Path: dreamEntry
class _TranslationsDreamEntryDe implements TranslationsDreamEntryEn {
	_TranslationsDreamEntryDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get newDream => 'Neuer Traum';
	@override String get saveDream => 'Traum speichern';
	@override String get discardDream => 'Verwerfen';
	@override String get shareDream => 'Teilen';
	@override String get dreamTitle => 'Traumtitel';
	@override String get dreamTitleHint => 'Bitte geben Sie einen Titel für Ihren Traum ein';
	@override String get yourDream => 'Ihr Traum';
	@override late final _TranslationsDreamEntryTagsDe tags = _TranslationsDreamEntryTagsDe._(_root);
	@override String get moodRating => 'Stimmungsbewertung';
	@override String get failedToSaveDream => 'Traum konnte nicht gespeichert werden';
	@override late final _TranslationsDreamEntryDreamDetailsDe dreamDetails = _TranslationsDreamEntryDreamDetailsDe._(_root);
	@override late final _TranslationsDreamEntryDreamFormDe dreamForm = _TranslationsDreamEntryDreamFormDe._(_root);
	@override late final _TranslationsDreamEntryInterpretationDe interpretation = _TranslationsDreamEntryInterpretationDe._(_root);
}

// Path: dreamFilterOptions
class _TranslationsDreamFilterOptionsDe implements TranslationsDreamFilterOptionsEn {
	_TranslationsDreamFilterOptionsDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get selectTag => 'Tag auswählen';
	@override String get tags => 'Tags';
	@override String get all => 'Alle';
	@override String get week => 'Diese Woche';
	@override String get month => 'Dieser Monat';
	@override String get favorites => 'Favoriten';
}

// Path: searchDreams
class _TranslationsSearchDreamsDe implements TranslationsSearchDreamsEn {
	_TranslationsSearchDreamsDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get searchDreams => 'Traum suchen';
	@override String get retryButton => 'Erneut versuchen';
	@override String get noResults => 'Kein Traum gefunden';
	@override String get delete => 'Löschen';
	@override String get undoButton => 'Rückgängig';
	@override String get dreamDeleted => 'Traum gelöscht';
	@override String get deleteConfirmation => 'Sind Sie sicher, dass Sie "{title}" löschen möchten?';
	@override String get deleteWarning => 'Diese Aktion kann nicht rückgängig gemacht werden.';
}

// Path: dreamHistory
class _TranslationsDreamHistoryDe implements TranslationsDreamHistoryEn {
	_TranslationsDreamHistoryDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get dreamHistory => 'Traumhistorie';
	@override String get noDreams => 'Keine Träume gespeichert';
	@override String get noDreamsCaption => 'Sie haben noch keine Träume gespeichert. Beginnen Sie noch heute damit.';
}

// Path: profile
class _TranslationsProfileDe implements TranslationsProfileEn {
	_TranslationsProfileDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get profile => 'Profil';
	@override String get username => 'Benutzername';
	@override String get email => 'E-Mail';
	@override String get notifications => 'Benachrichtigungen';
	@override String get settings => 'Einstellungen';
	@override String get logout => 'Abmelden';
	@override String get changePassword => 'Passwort ändern';
	@override String get profileNotFound => 'Profil nicht gefunden';
	@override String get closeBackgroundAnimation => 'Hintergrundanimation schließen';
	@override String get displayNameUpdated => 'Benutzername erfolgreich aktualisiert';
	@override late final _TranslationsProfilePersonalizationDe personalization = _TranslationsProfilePersonalizationDe._(_root);
	@override String get dreamStats => 'Traumstatistiken';
	@override String get currentStreak => 'Aktuelle Serie';
	@override String get longestStreak => 'Längste Serie';
	@override String get totalDreams => 'Gesamte Träume';
	@override String get weeklyDreams => 'Wöchentliche Träume';
	@override String get completionRate => 'Abschlussrate';
	@override String get language => 'Sprache';
	@override String get english => 'Englisch';
	@override String get turkish => 'Türkisch';
	@override String get german => 'Deutsch';
	@override late final _TranslationsProfileReminderDe reminder = _TranslationsProfileReminderDe._(_root);
	@override late final _TranslationsProfileDeleteAccountDe deleteAccount = _TranslationsProfileDeleteAccountDe._(_root);
}

// Path: common
class _TranslationsCommonDe implements TranslationsCommonEn {
	_TranslationsCommonDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get cancel => 'Abbrechen';
	@override String get confirm => 'Bestätigen';
	@override String get success => 'Erfolgreich';
	@override String get error => 'Fehler';
	@override String get loading => 'Lädt...';
}

// Path: core.mode
class _TranslationsCoreModeDe implements TranslationsCoreModeEn {
	_TranslationsCoreModeDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get systemMode => 'System';
	@override String get darkMode => 'Dunkler Modus';
	@override String get lightMode => 'Heller Modus';
}

// Path: core.errors
class _TranslationsCoreErrorsDe implements TranslationsCoreErrorsEn {
	_TranslationsCoreErrorsDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get error => 'Fehler';
	@override String get userNotFound => 'Benutzer nicht gefunden';
	@override String get wrongPassword => 'Ungültiges Passwort';
	@override String get emailAlreadyInUse => 'E-Mail bereits registriert';
	@override String get invalidEmail => 'Ungültiges E-Mail-Format';
	@override String get weakPassword => 'Passwort zu schwach';
	@override String get unknown => 'E-Mail oder Passwort falsch';
	@override String get tryAgain => 'Bitte versuchen Sie es erneut';
	@override String get userNotAuthenticated => 'Benutzer konnte nicht authentifiziert werden';
}

// Path: core.emailVerification
class _TranslationsCoreEmailVerificationDe implements TranslationsCoreEmailVerificationEn {
	_TranslationsCoreEmailVerificationDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'E-Mail bestätigen';
	@override String get message => 'Eine Bestätigungs-E-Mail wurde an Ihre E-Mail-Adresse gesendet. Bitte bestätigen Sie Ihre E-Mail, um fortzufahren.';
	@override String get continue_ => 'Trotzdem fortfahren';
	@override String get resend => 'E-Mail erneut senden';
	@override String get resent => 'Bestätigungs-E-Mail wurde erneut gesendet';
}

// Path: core.emailVerificationDialog
class _TranslationsCoreEmailVerificationDialogDe implements TranslationsCoreEmailVerificationDialogEn {
	_TranslationsCoreEmailVerificationDialogDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get notVerifiedTitle => 'E-Mail nicht verifiziert';
	@override String get verifyTitle => 'E-Mail bestätigen';
	@override String get notVerifiedMessage => 'Bitte bestätigen Sie Ihre E-Mail, bevor Sie sich anmelden. Überprüfen Sie Ihren Posteingang auf den Bestätigungslink.';
	@override String verifyMessage({required Object email}) => 'Eine Bestätigungs-E-Mail wurde an ${email} gesendet. Bitte bestätigen Sie Ihre E-Mail, um fortzufahren.';
	@override String get needVerification => 'Benötigen Sie eine neue Bestätigungs-E-Mail?';
	@override String get checkInbox => 'Überprüfen Sie Ihren Posteingang und Spam-Ordner auf den Bestätigungslink.';
	@override String get cancel => 'Abbrechen';
	@override String get resend => 'Erneut senden';
	@override String get goToLogin => 'Zur Anmeldung';
}

// Path: registration.email
class _TranslationsRegistrationEmailDe implements TranslationsRegistrationEmailEn {
	_TranslationsRegistrationEmailDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get emailText => 'E-Mail';
	@override String get emailHint => 'Bitte geben Sie Ihre E-Mail ein';
	@override String get emailValidation => 'E-Mail erforderlich';
	@override String get emailInvalid => 'Bitte geben Sie eine gültige E-Mail ein';
}

// Path: registration.password
class _TranslationsRegistrationPasswordDe implements TranslationsRegistrationPasswordEn {
	_TranslationsRegistrationPasswordDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get passwordText => 'Passwort';
	@override String get passwordHint => 'Bitte geben Sie Ihr Passwort ein';
	@override String get passwordValidation => 'Passwort erforderlich';
	@override String passwordShort({required Object minPasswordSize}) => 'Passwort muss mindestens ${minPasswordSize} Zeichen lang sein';
	@override late final _TranslationsRegistrationPasswordChangePasswordDe changePassword = _TranslationsRegistrationPasswordChangePasswordDe._(_root);
	@override late final _TranslationsRegistrationPasswordResetPasswordDe resetPassword = _TranslationsRegistrationPasswordResetPasswordDe._(_root);
}

// Path: registration.confirmPassword
class _TranslationsRegistrationConfirmPasswordDe implements TranslationsRegistrationConfirmPasswordEn {
	_TranslationsRegistrationConfirmPasswordDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get confirmPasswordText => 'Passwort bestätigen';
	@override String get confirmPasswordHint => 'Bitte geben Sie Ihr Passwort erneut ein';
	@override String get confirmPasswordValidation => 'Passwortbestätigung erforderlich';
	@override String get confirmPasswordMismatch => 'Passwörter stimmen nicht überein';
}

// Path: registration.signUp
class _TranslationsRegistrationSignUpDe implements TranslationsRegistrationSignUpEn {
	_TranslationsRegistrationSignUpDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get signUpText => 'Konto erstellen';
	@override String get signUpCaption => 'Treten Sie noch heute dem Traumtagebuch bei';
	@override String get subtitle => 'Begleiten Sie uns auf der Reise durch Ihre Träume';
	@override String get alreadyHaveAccount => 'Haben Sie bereits ein Konto?';
}

// Path: registration.signIn
class _TranslationsRegistrationSignInDe implements TranslationsRegistrationSignInEn {
	_TranslationsRegistrationSignInDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get signInText => 'Anmelden';
	@override String get forgotPassword => 'Passwort vergessen?';
	@override String get subtitle => 'Erforschen Sie Ihre Träume mit KI';
	@override String get or => 'ODER';
}

// Path: registration.signOut
class _TranslationsRegistrationSignOutDe implements TranslationsRegistrationSignOutEn {
	_TranslationsRegistrationSignOutDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get signOutText => 'Abmelden';
}

// Path: dreamEntry.tags
class _TranslationsDreamEntryTagsDe implements TranslationsDreamEntryTagsEn {
	_TranslationsDreamEntryTagsDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get tags => 'Tags';
	@override String get Happiness => 'Glück';
	@override String get Anxiety => 'Angst';
	@override String get Fear => 'Furcht';
	@override String get Joy => 'Freude';
	@override String get Anger => 'Wut';
	@override String get Confusion => 'Verwirrung';
	@override String get Love => 'Liebe';
	@override String get Peace => 'Frieden';
	@override String get Sadness => 'Traurigkeit';
	@override String get Excitement => 'Aufregung';
}

// Path: dreamEntry.dreamDetails
class _TranslationsDreamEntryDreamDetailsDe implements TranslationsDreamEntryDreamDetailsEn {
	_TranslationsDreamEntryDreamDetailsDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get addDetails => 'Details hinzufügen';
	@override String get addTags => 'Tags hinzufügen';
	@override String get moodRating => 'Stimmungsbewertung';
	@override String get confirmButton => 'Bestätigen';
}

// Path: dreamEntry.dreamForm
class _TranslationsDreamEntryDreamFormDe implements TranslationsDreamEntryDreamFormEn {
	_TranslationsDreamEntryDreamFormDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get record => 'Traum aufzeichnen';
	@override String get content => 'Trauminhalt';
	@override String get contentHint => 'Bitte geben Sie Ihren Traum ein';
	@override String get getInterpretation => 'Interpretation erhalten';
	@override String get noAttemptsLeft => 'Keine Versuche mehr für heute. Sehen Sie sich eine Werbung an, um mehr Träume zu interpretieren.';
	@override String get watchAdError => 'Bitte sehen Sie sich die Werbung an, um heute mehr Träume zu interpretieren.';
	@override String get dreamSaved => 'Traum erfolgreich gespeichert';
	@override String get watchAdForInterpretation => 'Werbung ansehen, um yorum zu erhalten';
	@override String get remainingAttempts => 'Verbleibende Versuche heute';
}

// Path: dreamEntry.interpretation
class _TranslationsDreamEntryInterpretationDe implements TranslationsDreamEntryInterpretationEn {
	_TranslationsDreamEntryInterpretationDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Traumdeutung';
	@override String get interpretationText => 'Deutung';
	@override String get saveButton => 'Deutung speichern';
	@override String get shareButton => 'Deutung teilen';
}

// Path: profile.personalization
class _TranslationsProfilePersonalizationDe implements TranslationsProfilePersonalizationEn {
	_TranslationsProfilePersonalizationDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Personalisieren Sie Ihr Profil';
	@override String get description => 'Helfen Sie uns, Sie besser zu verstehen, um personalisierte Traumdeutungen anzubieten.';
	@override String get gender => 'Geschlecht';
	@override String get birthDate => 'Geburtsdatum';
	@override String get selectBirthDate => 'Geburtsdatum auswählen';
	@override String get horoscope => 'Sternzeichen';
	@override String get occupation => 'Beruf';
	@override late final _TranslationsProfilePersonalizationOccupationOptionsDe occupationOptions = _TranslationsProfilePersonalizationOccupationOptionsDe._(_root);
	@override String get relationshipStatus => 'Beziehungsstatus';
	@override String get interests => 'Ihre Interessen';
	@override String get submit => 'Speichern und fortfahren';
	@override late final _TranslationsProfilePersonalizationGenderOptionsDe genderOptions = _TranslationsProfilePersonalizationGenderOptionsDe._(_root);
	@override late final _TranslationsProfilePersonalizationHoroscopeOptionsDe horoscopeOptions = _TranslationsProfilePersonalizationHoroscopeOptionsDe._(_root);
	@override late final _TranslationsProfilePersonalizationRelationshipOptionsDe relationshipOptions = _TranslationsProfilePersonalizationRelationshipOptionsDe._(_root);
	@override late final _TranslationsProfilePersonalizationInterestOptionsDe interestOptions = _TranslationsProfilePersonalizationInterestOptionsDe._(_root);
}

// Path: profile.reminder
class _TranslationsProfileReminderDe implements TranslationsProfileReminderEn {
	_TranslationsProfileReminderDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get setTime => 'Erinnerung setzen';
	@override String get chooseTime => 'Wählen Sie aus, wann Sie erinnert werden möchten';
	@override String get description => 'Wir senden Ihnen eine Benachrichtigung, um Ihnen zu helfen, sich an Ihre Träume zu erinnern';
	@override String get earlyMorning => 'Früher Morgen';
	@override String get earlyMorningTime => '06:00';
	@override String get afternoon => 'Nachmittag';
	@override String get afternoonTime => '14:00';
	@override String get nighttime => 'Nachtzeit';
	@override String get nighttimeTime => '22:00';
	@override String get custom => 'Benutzerdefiniert';
	@override String get setCustomTime => 'Ihre Zeit einstellen';
	@override String get saveButton => 'Erinnerung speichern';
	@override String get skipButton => 'Jetzt überspringen';
	@override String get savedSuccess => 'Erinnerungseinstellungen erfolgreich gespeichert';
}

// Path: profile.deleteAccount
class _TranslationsProfileDeleteAccountDe implements TranslationsProfileDeleteAccountEn {
	_TranslationsProfileDeleteAccountDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Konto löschen';
	@override String get message => 'Sind Sie sicher, dass Sie Ihr Konto löschen möchten? Diese Aktion kann nicht rückgängig gemacht werden und wird alle Ihre Daten einschließlich Träume, Deutungen und Einstellungen permanent löschen.';
	@override String get warning => 'Diese Aktion kann nicht rückgängig gemacht werden und wird alle Ihre Daten einschließlich Träume, Deutungen und Einstellungen permanent löschen.';
	@override String get confirm => 'Ja, löschen';
}

// Path: registration.password.changePassword
class _TranslationsRegistrationPasswordChangePasswordDe implements TranslationsRegistrationPasswordChangePasswordEn {
	_TranslationsRegistrationPasswordChangePasswordDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get changePasswordText => 'Passwort ändern';
	@override String get currentPassword => 'Aktuelles Passwort';
	@override String get currentPasswordValidator => 'Bitte geben Sie Ihr aktuelles Passwort ein';
	@override String get newPassword => 'Neues Passwort';
	@override String get newPasswordValidator => 'Bitte geben Sie ein neues Passwort ein';
	@override String get resetPasswordButton => 'Passwort zurücksetzen';
	@override String get confirmNewPassword => 'Neues Passwort bestätigen';
	@override String get success => 'Passwort erfolgreich geändert';
}

// Path: registration.password.resetPassword
class _TranslationsRegistrationPasswordResetPasswordDe implements TranslationsRegistrationPasswordResetPasswordEn {
	_TranslationsRegistrationPasswordResetPasswordDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get resetPasswordText => 'Passwort zurücksetzen';
	@override String get resetPasswordButton => 'Zurücksetzungslink senden';
	@override String get resetPasswordCaption => 'Geben Sie Ihre E-Mail-Adresse ein, wir senden Ihnen einen Link zum Zurücksetzen des Passworts.';
	@override String get resetPasswordSuccess => 'E-Mail zum Zurücksetzen des Passworts gesendet. Bitte überprüfen Sie Ihren Posteingang.';
	@override String get resetPasswordError => 'Fehler beim Senden der Zurücksetzungs-E-Mail';
	@override String get backToSignIn => 'Zurück zur Anmeldung';
}

// Path: profile.personalization.occupationOptions
class _TranslationsProfilePersonalizationOccupationOptionsDe implements TranslationsProfilePersonalizationOccupationOptionsEn {
	_TranslationsProfilePersonalizationOccupationOptionsDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get homemaker => 'Hausfrau/Hausmann';
	@override String get unemployed => 'Arbeitslos';
	@override String get jobSeeker => 'Arbeitssuchend';
	@override String get student => 'Student/in';
	@override String get academic => 'Akademiker/in';
	@override String get selfEmployed => 'Selbstständig';
	@override String get publicSector => 'Öffentlicher Dienst';
	@override String get privateSector => 'Privatwirtschaft';
	@override String get retired => 'Rentner/in';
}

// Path: profile.personalization.genderOptions
class _TranslationsProfilePersonalizationGenderOptionsDe implements TranslationsProfilePersonalizationGenderOptionsEn {
	_TranslationsProfilePersonalizationGenderOptionsDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get male => 'Männlich';
	@override String get female => 'Weiblich';
	@override String get other => 'Andere';
	@override String get preferNotToSay => 'Möchte ich nicht angeben';
}

// Path: profile.personalization.horoscopeOptions
class _TranslationsProfilePersonalizationHoroscopeOptionsDe implements TranslationsProfilePersonalizationHoroscopeOptionsEn {
	_TranslationsProfilePersonalizationHoroscopeOptionsDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get aries => 'Widder';
	@override String get taurus => 'Stier';
	@override String get gemini => 'Zwillinge';
	@override String get cancer => 'Krebs';
	@override String get leo => 'Löwe';
	@override String get virgo => 'Jungfrau';
	@override String get libra => 'Waage';
	@override String get scorpio => 'Skorpion';
	@override String get sagittarius => 'Schütze';
	@override String get capricorn => 'Steinbock';
	@override String get aquarius => 'Wassermann';
	@override String get pisces => 'Fische';
}

// Path: profile.personalization.relationshipOptions
class _TranslationsProfilePersonalizationRelationshipOptionsDe implements TranslationsProfilePersonalizationRelationshipOptionsEn {
	_TranslationsProfilePersonalizationRelationshipOptionsDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get single => 'Single';
	@override String get inRelationship => 'In einer Beziehung';
	@override String get married => 'Verheiratet';
	@override String get preferNotToSay => 'Möchte ich nicht angeben';
}

// Path: profile.personalization.interestOptions
class _TranslationsProfilePersonalizationInterestOptionsDe implements TranslationsProfilePersonalizationInterestOptionsEn {
	_TranslationsProfilePersonalizationInterestOptionsDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get spirituality => 'Spiritualität';
	@override String get meditation => 'Meditation';
	@override String get psychology => 'Psychologie';
	@override String get selfImprovement => 'Selbstverbesserung';
	@override String get art => 'Kunst';
	@override String get music => 'Musik';
	@override String get travel => 'Reisen';
	@override String get nature => 'Natur';
	@override String get technology => 'Technologie';
	@override String get science => 'Wissenschaft';
	@override String get sports => 'Sport';
	@override String get cooking => 'Kochen';
	@override String get reading => 'Lesen';
	@override String get writing => 'Schreiben';
	@override String get photography => 'Fotografie';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsDe {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'core.appName': return 'Dreamalyze';
			case 'core.mode.systemMode': return 'System';
			case 'core.mode.darkMode': return 'Dunkler Modus';
			case 'core.mode.lightMode': return 'Heller Modus';
			case 'core.errors.error': return 'Fehler';
			case 'core.errors.userNotFound': return 'Benutzer nicht gefunden';
			case 'core.errors.wrongPassword': return 'Ungültiges Passwort';
			case 'core.errors.emailAlreadyInUse': return 'E-Mail bereits registriert';
			case 'core.errors.invalidEmail': return 'Ungültiges E-Mail-Format';
			case 'core.errors.weakPassword': return 'Passwort zu schwach';
			case 'core.errors.unknown': return 'E-Mail oder Passwort falsch';
			case 'core.errors.tryAgain': return 'Bitte versuchen Sie es erneut';
			case 'core.errors.userNotAuthenticated': return 'Benutzer konnte nicht authentifiziert werden';
			case 'core.success': return 'Erfolgreich';
			case 'core.emailVerification.title': return 'E-Mail bestätigen';
			case 'core.emailVerification.message': return 'Eine Bestätigungs-E-Mail wurde an Ihre E-Mail-Adresse gesendet. Bitte bestätigen Sie Ihre E-Mail, um fortzufahren.';
			case 'core.emailVerification.continue_': return 'Trotzdem fortfahren';
			case 'core.emailVerification.resend': return 'E-Mail erneut senden';
			case 'core.emailVerification.resent': return 'Bestätigungs-E-Mail wurde erneut gesendet';
			case 'core.emailVerificationDialog.notVerifiedTitle': return 'E-Mail nicht verifiziert';
			case 'core.emailVerificationDialog.verifyTitle': return 'E-Mail bestätigen';
			case 'core.emailVerificationDialog.notVerifiedMessage': return 'Bitte bestätigen Sie Ihre E-Mail, bevor Sie sich anmelden. Überprüfen Sie Ihren Posteingang auf den Bestätigungslink.';
			case 'core.emailVerificationDialog.verifyMessage': return ({required Object email}) => 'Eine Bestätigungs-E-Mail wurde an ${email} gesendet. Bitte bestätigen Sie Ihre E-Mail, um fortzufahren.';
			case 'core.emailVerificationDialog.needVerification': return 'Benötigen Sie eine neue Bestätigungs-E-Mail?';
			case 'core.emailVerificationDialog.checkInbox': return 'Überprüfen Sie Ihren Posteingang und Spam-Ordner auf den Bestätigungslink.';
			case 'core.emailVerificationDialog.cancel': return 'Abbrechen';
			case 'core.emailVerificationDialog.resend': return 'Erneut senden';
			case 'core.emailVerificationDialog.goToLogin': return 'Zur Anmeldung';
			case 'registration.welcomeText': return 'Willkommen zurück';
			case 'registration.email.emailText': return 'E-Mail';
			case 'registration.email.emailHint': return 'Bitte geben Sie Ihre E-Mail ein';
			case 'registration.email.emailValidation': return 'E-Mail erforderlich';
			case 'registration.email.emailInvalid': return 'Bitte geben Sie eine gültige E-Mail ein';
			case 'registration.password.passwordText': return 'Passwort';
			case 'registration.password.passwordHint': return 'Bitte geben Sie Ihr Passwort ein';
			case 'registration.password.passwordValidation': return 'Passwort erforderlich';
			case 'registration.password.passwordShort': return ({required Object minPasswordSize}) => 'Passwort muss mindestens ${minPasswordSize} Zeichen lang sein';
			case 'registration.password.changePassword.changePasswordText': return 'Passwort ändern';
			case 'registration.password.changePassword.currentPassword': return 'Aktuelles Passwort';
			case 'registration.password.changePassword.currentPasswordValidator': return 'Bitte geben Sie Ihr aktuelles Passwort ein';
			case 'registration.password.changePassword.newPassword': return 'Neues Passwort';
			case 'registration.password.changePassword.newPasswordValidator': return 'Bitte geben Sie ein neues Passwort ein';
			case 'registration.password.changePassword.resetPasswordButton': return 'Passwort zurücksetzen';
			case 'registration.password.changePassword.confirmNewPassword': return 'Neues Passwort bestätigen';
			case 'registration.password.changePassword.success': return 'Passwort erfolgreich geändert';
			case 'registration.password.resetPassword.resetPasswordText': return 'Passwort zurücksetzen';
			case 'registration.password.resetPassword.resetPasswordButton': return 'Zurücksetzungslink senden';
			case 'registration.password.resetPassword.resetPasswordCaption': return 'Geben Sie Ihre E-Mail-Adresse ein, wir senden Ihnen einen Link zum Zurücksetzen des Passworts.';
			case 'registration.password.resetPassword.resetPasswordSuccess': return 'E-Mail zum Zurücksetzen des Passworts gesendet. Bitte überprüfen Sie Ihren Posteingang.';
			case 'registration.password.resetPassword.resetPasswordError': return 'Fehler beim Senden der Zurücksetzungs-E-Mail';
			case 'registration.password.resetPassword.backToSignIn': return 'Zurück zur Anmeldung';
			case 'registration.confirmPassword.confirmPasswordText': return 'Passwort bestätigen';
			case 'registration.confirmPassword.confirmPasswordHint': return 'Bitte geben Sie Ihr Passwort erneut ein';
			case 'registration.confirmPassword.confirmPasswordValidation': return 'Passwortbestätigung erforderlich';
			case 'registration.confirmPassword.confirmPasswordMismatch': return 'Passwörter stimmen nicht überein';
			case 'registration.signUp.signUpText': return 'Konto erstellen';
			case 'registration.signUp.signUpCaption': return 'Treten Sie noch heute dem Traumtagebuch bei';
			case 'registration.signUp.subtitle': return 'Begleiten Sie uns auf der Reise durch Ihre Träume';
			case 'registration.signUp.alreadyHaveAccount': return 'Haben Sie bereits ein Konto?';
			case 'registration.signIn.signInText': return 'Anmelden';
			case 'registration.signIn.forgotPassword': return 'Passwort vergessen?';
			case 'registration.signIn.subtitle': return 'Erforschen Sie Ihre Träume mit KI';
			case 'registration.signIn.or': return 'ODER';
			case 'registration.signOut.signOutText': return 'Abmelden';
			case 'dreamEntry.newDream': return 'Neuer Traum';
			case 'dreamEntry.saveDream': return 'Traum speichern';
			case 'dreamEntry.discardDream': return 'Verwerfen';
			case 'dreamEntry.shareDream': return 'Teilen';
			case 'dreamEntry.dreamTitle': return 'Traumtitel';
			case 'dreamEntry.dreamTitleHint': return 'Bitte geben Sie einen Titel für Ihren Traum ein';
			case 'dreamEntry.yourDream': return 'Ihr Traum';
			case 'dreamEntry.tags.tags': return 'Tags';
			case 'dreamEntry.tags.Happiness': return 'Glück';
			case 'dreamEntry.tags.Anxiety': return 'Angst';
			case 'dreamEntry.tags.Fear': return 'Furcht';
			case 'dreamEntry.tags.Joy': return 'Freude';
			case 'dreamEntry.tags.Anger': return 'Wut';
			case 'dreamEntry.tags.Confusion': return 'Verwirrung';
			case 'dreamEntry.tags.Love': return 'Liebe';
			case 'dreamEntry.tags.Peace': return 'Frieden';
			case 'dreamEntry.tags.Sadness': return 'Traurigkeit';
			case 'dreamEntry.tags.Excitement': return 'Aufregung';
			case 'dreamEntry.moodRating': return 'Stimmungsbewertung';
			case 'dreamEntry.failedToSaveDream': return 'Traum konnte nicht gespeichert werden';
			case 'dreamEntry.dreamDetails.addDetails': return 'Details hinzufügen';
			case 'dreamEntry.dreamDetails.addTags': return 'Tags hinzufügen';
			case 'dreamEntry.dreamDetails.moodRating': return 'Stimmungsbewertung';
			case 'dreamEntry.dreamDetails.confirmButton': return 'Bestätigen';
			case 'dreamEntry.dreamForm.record': return 'Traum aufzeichnen';
			case 'dreamEntry.dreamForm.content': return 'Trauminhalt';
			case 'dreamEntry.dreamForm.contentHint': return 'Bitte geben Sie Ihren Traum ein';
			case 'dreamEntry.dreamForm.getInterpretation': return 'Interpretation erhalten';
			case 'dreamEntry.dreamForm.noAttemptsLeft': return 'Keine Versuche mehr für heute. Sehen Sie sich eine Werbung an, um mehr Träume zu interpretieren.';
			case 'dreamEntry.dreamForm.watchAdError': return 'Bitte sehen Sie sich die Werbung an, um heute mehr Träume zu interpretieren.';
			case 'dreamEntry.dreamForm.dreamSaved': return 'Traum erfolgreich gespeichert';
			case 'dreamEntry.dreamForm.watchAdForInterpretation': return 'Werbung ansehen, um yorum zu erhalten';
			case 'dreamEntry.dreamForm.remainingAttempts': return 'Verbleibende Versuche heute';
			case 'dreamEntry.interpretation.title': return 'Traumdeutung';
			case 'dreamEntry.interpretation.interpretationText': return 'Deutung';
			case 'dreamEntry.interpretation.saveButton': return 'Deutung speichern';
			case 'dreamEntry.interpretation.shareButton': return 'Deutung teilen';
			case 'dreamDetail': return 'Traumbeschreibung';
			case 'dreamFilterOptions.selectTag': return 'Tag auswählen';
			case 'dreamFilterOptions.tags': return 'Tags';
			case 'dreamFilterOptions.all': return 'Alle';
			case 'dreamFilterOptions.week': return 'Diese Woche';
			case 'dreamFilterOptions.month': return 'Dieser Monat';
			case 'dreamFilterOptions.favorites': return 'Favoriten';
			case 'searchDreams.searchDreams': return 'Traum suchen';
			case 'searchDreams.retryButton': return 'Erneut versuchen';
			case 'searchDreams.noResults': return 'Kein Traum gefunden';
			case 'searchDreams.delete': return 'Löschen';
			case 'searchDreams.undoButton': return 'Rückgängig';
			case 'searchDreams.dreamDeleted': return 'Traum gelöscht';
			case 'searchDreams.deleteConfirmation': return 'Sind Sie sicher, dass Sie "{title}" löschen möchten?';
			case 'searchDreams.deleteWarning': return 'Diese Aktion kann nicht rückgängig gemacht werden.';
			case 'dreamHistory.dreamHistory': return 'Traumhistorie';
			case 'dreamHistory.noDreams': return 'Keine Träume gespeichert';
			case 'dreamHistory.noDreamsCaption': return 'Sie haben noch keine Träume gespeichert. Beginnen Sie noch heute damit.';
			case 'profile.profile': return 'Profil';
			case 'profile.username': return 'Benutzername';
			case 'profile.email': return 'E-Mail';
			case 'profile.notifications': return 'Benachrichtigungen';
			case 'profile.settings': return 'Einstellungen';
			case 'profile.logout': return 'Abmelden';
			case 'profile.changePassword': return 'Passwort ändern';
			case 'profile.profileNotFound': return 'Profil nicht gefunden';
			case 'profile.closeBackgroundAnimation': return 'Hintergrundanimation schließen';
			case 'profile.displayNameUpdated': return 'Benutzername erfolgreich aktualisiert';
			case 'profile.personalization.title': return 'Personalisieren Sie Ihr Profil';
			case 'profile.personalization.description': return 'Helfen Sie uns, Sie besser zu verstehen, um personalisierte Traumdeutungen anzubieten.';
			case 'profile.personalization.gender': return 'Geschlecht';
			case 'profile.personalization.birthDate': return 'Geburtsdatum';
			case 'profile.personalization.selectBirthDate': return 'Geburtsdatum auswählen';
			case 'profile.personalization.horoscope': return 'Sternzeichen';
			case 'profile.personalization.occupation': return 'Beruf';
			case 'profile.personalization.occupationOptions.homemaker': return 'Hausfrau/Hausmann';
			case 'profile.personalization.occupationOptions.unemployed': return 'Arbeitslos';
			case 'profile.personalization.occupationOptions.jobSeeker': return 'Arbeitssuchend';
			case 'profile.personalization.occupationOptions.student': return 'Student/in';
			case 'profile.personalization.occupationOptions.academic': return 'Akademiker/in';
			case 'profile.personalization.occupationOptions.selfEmployed': return 'Selbstständig';
			case 'profile.personalization.occupationOptions.publicSector': return 'Öffentlicher Dienst';
			case 'profile.personalization.occupationOptions.privateSector': return 'Privatwirtschaft';
			case 'profile.personalization.occupationOptions.retired': return 'Rentner/in';
			case 'profile.personalization.relationshipStatus': return 'Beziehungsstatus';
			case 'profile.personalization.interests': return 'Ihre Interessen';
			case 'profile.personalization.submit': return 'Speichern und fortfahren';
			case 'profile.personalization.genderOptions.male': return 'Männlich';
			case 'profile.personalization.genderOptions.female': return 'Weiblich';
			case 'profile.personalization.genderOptions.other': return 'Andere';
			case 'profile.personalization.genderOptions.preferNotToSay': return 'Möchte ich nicht angeben';
			case 'profile.personalization.horoscopeOptions.aries': return 'Widder';
			case 'profile.personalization.horoscopeOptions.taurus': return 'Stier';
			case 'profile.personalization.horoscopeOptions.gemini': return 'Zwillinge';
			case 'profile.personalization.horoscopeOptions.cancer': return 'Krebs';
			case 'profile.personalization.horoscopeOptions.leo': return 'Löwe';
			case 'profile.personalization.horoscopeOptions.virgo': return 'Jungfrau';
			case 'profile.personalization.horoscopeOptions.libra': return 'Waage';
			case 'profile.personalization.horoscopeOptions.scorpio': return 'Skorpion';
			case 'profile.personalization.horoscopeOptions.sagittarius': return 'Schütze';
			case 'profile.personalization.horoscopeOptions.capricorn': return 'Steinbock';
			case 'profile.personalization.horoscopeOptions.aquarius': return 'Wassermann';
			case 'profile.personalization.horoscopeOptions.pisces': return 'Fische';
			case 'profile.personalization.relationshipOptions.single': return 'Single';
			case 'profile.personalization.relationshipOptions.inRelationship': return 'In einer Beziehung';
			case 'profile.personalization.relationshipOptions.married': return 'Verheiratet';
			case 'profile.personalization.relationshipOptions.preferNotToSay': return 'Möchte ich nicht angeben';
			case 'profile.personalization.interestOptions.spirituality': return 'Spiritualität';
			case 'profile.personalization.interestOptions.meditation': return 'Meditation';
			case 'profile.personalization.interestOptions.psychology': return 'Psychologie';
			case 'profile.personalization.interestOptions.selfImprovement': return 'Selbstverbesserung';
			case 'profile.personalization.interestOptions.art': return 'Kunst';
			case 'profile.personalization.interestOptions.music': return 'Musik';
			case 'profile.personalization.interestOptions.travel': return 'Reisen';
			case 'profile.personalization.interestOptions.nature': return 'Natur';
			case 'profile.personalization.interestOptions.technology': return 'Technologie';
			case 'profile.personalization.interestOptions.science': return 'Wissenschaft';
			case 'profile.personalization.interestOptions.sports': return 'Sport';
			case 'profile.personalization.interestOptions.cooking': return 'Kochen';
			case 'profile.personalization.interestOptions.reading': return 'Lesen';
			case 'profile.personalization.interestOptions.writing': return 'Schreiben';
			case 'profile.personalization.interestOptions.photography': return 'Fotografie';
			case 'profile.dreamStats': return 'Traumstatistiken';
			case 'profile.currentStreak': return 'Aktuelle Serie';
			case 'profile.longestStreak': return 'Längste Serie';
			case 'profile.totalDreams': return 'Gesamte Träume';
			case 'profile.weeklyDreams': return 'Wöchentliche Träume';
			case 'profile.completionRate': return 'Abschlussrate';
			case 'profile.language': return 'Sprache';
			case 'profile.english': return 'Englisch';
			case 'profile.turkish': return 'Türkisch';
			case 'profile.german': return 'Deutsch';
			case 'profile.reminder.setTime': return 'Erinnerung setzen';
			case 'profile.reminder.chooseTime': return 'Wählen Sie aus, wann Sie erinnert werden möchten';
			case 'profile.reminder.description': return 'Wir senden Ihnen eine Benachrichtigung, um Ihnen zu helfen, sich an Ihre Träume zu erinnern';
			case 'profile.reminder.earlyMorning': return 'Früher Morgen';
			case 'profile.reminder.earlyMorningTime': return '06:00';
			case 'profile.reminder.afternoon': return 'Nachmittag';
			case 'profile.reminder.afternoonTime': return '14:00';
			case 'profile.reminder.nighttime': return 'Nachtzeit';
			case 'profile.reminder.nighttimeTime': return '22:00';
			case 'profile.reminder.custom': return 'Benutzerdefiniert';
			case 'profile.reminder.setCustomTime': return 'Ihre Zeit einstellen';
			case 'profile.reminder.saveButton': return 'Erinnerung speichern';
			case 'profile.reminder.skipButton': return 'Jetzt überspringen';
			case 'profile.reminder.savedSuccess': return 'Erinnerungseinstellungen erfolgreich gespeichert';
			case 'profile.deleteAccount.title': return 'Konto löschen';
			case 'profile.deleteAccount.message': return 'Sind Sie sicher, dass Sie Ihr Konto löschen möchten? Diese Aktion kann nicht rückgängig gemacht werden und wird alle Ihre Daten einschließlich Träume, Deutungen und Einstellungen permanent löschen.';
			case 'profile.deleteAccount.warning': return 'Diese Aktion kann nicht rückgängig gemacht werden und wird alle Ihre Daten einschließlich Träume, Deutungen und Einstellungen permanent löschen.';
			case 'profile.deleteAccount.confirm': return 'Ja, löschen';
			case 'common.cancel': return 'Abbrechen';
			case 'common.confirm': return 'Bestätigen';
			case 'common.success': return 'Erfolgreich';
			case 'common.error': return 'Fehler';
			case 'common.loading': return 'Lädt...';
			default: return null;
		}
	}
}

