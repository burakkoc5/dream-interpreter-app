///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations implements BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	// Translations
	late final TranslationsCoreEn core = TranslationsCoreEn._(_root);
	late final TranslationsRegistrationEn registration = TranslationsRegistrationEn._(_root);
	late final TranslationsDreamEntryEn dreamEntry = TranslationsDreamEntryEn._(_root);
	String get dreamDetail => 'Dream Description';
	late final TranslationsDreamFilterOptionsEn dreamFilterOptions = TranslationsDreamFilterOptionsEn._(_root);
	late final TranslationsSearchDreamsEn searchDreams = TranslationsSearchDreamsEn._(_root);
	late final TranslationsDreamHistoryEn dreamHistory = TranslationsDreamHistoryEn._(_root);
	late final TranslationsProfileEn profile = TranslationsProfileEn._(_root);
}

// Path: core
class TranslationsCoreEn {
	TranslationsCoreEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get appName => 'Dream Journal';
	late final TranslationsCoreModeEn mode = TranslationsCoreModeEn._(_root);
	late final TranslationsCoreErrorsEn errors = TranslationsCoreErrorsEn._(_root);
}

// Path: registration
class TranslationsRegistrationEn {
	TranslationsRegistrationEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get welcomeText => 'Welcome Back';
	late final TranslationsRegistrationEmailEn email = TranslationsRegistrationEmailEn._(_root);
	late final TranslationsRegistrationPasswordEn password = TranslationsRegistrationPasswordEn._(_root);
	late final TranslationsRegistrationConfirmPasswordEn confirmPassword = TranslationsRegistrationConfirmPasswordEn._(_root);
	late final TranslationsRegistrationSignUpEn signUp = TranslationsRegistrationSignUpEn._(_root);
	late final TranslationsRegistrationSignInEn signIn = TranslationsRegistrationSignInEn._(_root);
	late final TranslationsRegistrationSignOutEn signOut = TranslationsRegistrationSignOutEn._(_root);
}

// Path: dreamEntry
class TranslationsDreamEntryEn {
	TranslationsDreamEntryEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get newDream => 'New Dream';
	String get saveDream => 'Save Dream';
	String get dreamTitle => 'Dream Title';
	String get dreamTitleHint => 'Please enter a title for your dream';
	String get yourDream => 'Your Dream';
	late final TranslationsDreamEntryTagsEn tags = TranslationsDreamEntryTagsEn._(_root);
	String get moodRating => 'Mood Rating';
	String get failedToSaveDream => 'Failed to save dream';
	late final TranslationsDreamEntryDreamDetailsEn dreamDetails = TranslationsDreamEntryDreamDetailsEn._(_root);
	late final TranslationsDreamEntryDreamFormEn dreamForm = TranslationsDreamEntryDreamFormEn._(_root);
	late final TranslationsDreamEntryInterpretationEn interpretation = TranslationsDreamEntryInterpretationEn._(_root);
}

// Path: dreamFilterOptions
class TranslationsDreamFilterOptionsEn {
	TranslationsDreamFilterOptionsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get all => 'All';
	String get week => 'This Week';
	String get month => 'This Month';
	String get favorites => 'Favorites';
}

// Path: searchDreams
class TranslationsSearchDreamsEn {
	TranslationsSearchDreamsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get searchDreams => 'Search Dreams';
	String get retryButton => 'Retry';
	String get noResults => 'No dreams found';
	String get delete => 'Delete';
	String get undoButton => 'Undo';
}

// Path: dreamHistory
class TranslationsDreamHistoryEn {
	TranslationsDreamHistoryEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get dreamHistory => 'Dream Journal';
	String get noDreams => 'No dreams recorded';
	String get noDreamsCaption => 'You haven\'t recorded any dreams yet. Start recording your dreams today.';
}

// Path: profile
class TranslationsProfileEn {
	TranslationsProfileEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get profile => 'Profile';
	String get username => 'Username';
	String get profileNotFound => 'Profile not found';
	String get dreamStats => 'Dream Statistics';
	String get totalDreams => 'Total Dreams';
	String get weeklyDreams => 'Weekly Dreams';
	String get completionRate => 'Completion Rate';
	String get settings => 'Settings';
	String get notifications => 'Notifications';
	String get changePassword => 'Change Password';
	String get logout => 'Logout';
}

// Path: core.mode
class TranslationsCoreModeEn {
	TranslationsCoreModeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get darkMode => 'Dark Mode';
	String get lightMode => 'Light Mode';
}

// Path: core.errors
class TranslationsCoreErrorsEn {
	TranslationsCoreErrorsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get error => 'Error';
	String get userNotFound => 'User not found';
	String get wrongPassword => 'Invalid password';
	String get emailAlreadyInUse => 'Email is already registered';
	String get invalidEmail => 'Invalid email format';
	String get weakPassword => 'Password is too weak';
	String get unknown => 'An unknown error occurred';
	String get tryAgain => 'Please try again';
}

// Path: registration.email
class TranslationsRegistrationEmailEn {
	TranslationsRegistrationEmailEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get emailText => 'Email';
	String get emailHint => 'Please enter your email';
	String get emailValidation => 'Email is required';
	String get emailInvalid => 'Please enter a valid email';
}

// Path: registration.password
class TranslationsRegistrationPasswordEn {
	TranslationsRegistrationPasswordEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get passwordText => 'Password';
	String get passwordHint => 'Please enter your password';
	String get passwordValidation => 'Password is required';
	String passwordShort({required Object minPasswordSize}) => 'Password must be at least ${minPasswordSize} characters';
	late final TranslationsRegistrationPasswordChangePasswordEn changePassword = TranslationsRegistrationPasswordChangePasswordEn._(_root);
	late final TranslationsRegistrationPasswordResetPasswordEn resetPassword = TranslationsRegistrationPasswordResetPasswordEn._(_root);
}

// Path: registration.confirmPassword
class TranslationsRegistrationConfirmPasswordEn {
	TranslationsRegistrationConfirmPasswordEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get confirmPasswordText => 'Confirm Password';
	String get confirmPasswordHint => 'Re-enter your password';
	String get confirmPasswordValidation => 'Re-enter password is required';
	String get confirmPasswordMismatch => 'Passwords do not match';
}

// Path: registration.signUp
class TranslationsRegistrationSignUpEn {
	TranslationsRegistrationSignUpEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get signUpText => 'Create Account';
	String get signUpCaption => 'Join Dream Journal today';
	String get alreadyHaveAccount => 'Already have an account?';
}

// Path: registration.signIn
class TranslationsRegistrationSignInEn {
	TranslationsRegistrationSignInEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get signInText => 'Sign In';
	String get forgotPassword => 'Forgot Password?';
}

// Path: registration.signOut
class TranslationsRegistrationSignOutEn {
	TranslationsRegistrationSignOutEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get signOutText => 'Sign Out';
}

// Path: dreamEntry.tags
class TranslationsDreamEntryTagsEn {
	TranslationsDreamEntryTagsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get tags => 'Tags';
	String get Happiness => 'happiness';
	String get Anxiety => 'anxiety';
	String get Fear => 'fear';
	String get Joy => 'joy';
	String get Anger => 'anger';
	String get Confusion => 'confusion';
	String get Love => 'love';
	String get Peace => 'peace';
	String get Sadness => 'sadness';
	String get Excitement => 'excitement';
}

// Path: dreamEntry.dreamDetails
class TranslationsDreamEntryDreamDetailsEn {
	TranslationsDreamEntryDreamDetailsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get addDetails => 'Add Details';
	String get addTags => 'Add tags';
	String get moodRating => 'Mood Rating';
	String get confirmButton => 'Confirm';
}

// Path: dreamEntry.dreamForm
class TranslationsDreamEntryDreamFormEn {
	TranslationsDreamEntryDreamFormEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get record => 'Record Your Dream';
	String get content => 'Dream Content';
	String get contentHint => 'Please enter your dream content';
	String get getInterpretation => 'Get Interpretation';
}

// Path: dreamEntry.interpretation
class TranslationsDreamEntryInterpretationEn {
	TranslationsDreamEntryInterpretationEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Dream Interpretation';
	String get interpretationText => 'Interpretation';
	String get saveButton => 'Save Interpretation';
	String get shareButton => 'Share Interpretation';
}

// Path: registration.password.changePassword
class TranslationsRegistrationPasswordChangePasswordEn {
	TranslationsRegistrationPasswordChangePasswordEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get changePasswordText => 'Change Password';
	String get currentPassword => 'Current Password';
	String get currentPasswordValidator => 'Please enter your current password';
	String get newPassword => 'New Password';
	String get newPasswordValidator => 'Please enter a new password';
	String get resetPasswordButton => 'Reset Password';
	String get confirmNewPassword => 'Confirm New Password';
	String get success => 'Password successfully changed';
}

// Path: registration.password.resetPassword
class TranslationsRegistrationPasswordResetPasswordEn {
	TranslationsRegistrationPasswordResetPasswordEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get resetPasswordText => 'Reset Password';
	String get resetPasswordButton => 'Send Reset link';
	String get resetPasswordCaption => 'Enter your email address and we\'ll send you a link to reset your password.';
	String get resetPasswordSuccess => 'Password reset email sent. Please check your inbox.';
	String get resetPasswordError => 'Error sending password reset email';
	String get backToSignIn => 'Back to Sign In';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on Translations {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'core.appName': return 'Dream Journal';
			case 'core.mode.darkMode': return 'Dark Mode';
			case 'core.mode.lightMode': return 'Light Mode';
			case 'core.errors.error': return 'Error';
			case 'core.errors.userNotFound': return 'User not found';
			case 'core.errors.wrongPassword': return 'Invalid password';
			case 'core.errors.emailAlreadyInUse': return 'Email is already registered';
			case 'core.errors.invalidEmail': return 'Invalid email format';
			case 'core.errors.weakPassword': return 'Password is too weak';
			case 'core.errors.unknown': return 'An unknown error occurred';
			case 'core.errors.tryAgain': return 'Please try again';
			case 'registration.welcomeText': return 'Welcome Back';
			case 'registration.email.emailText': return 'Email';
			case 'registration.email.emailHint': return 'Please enter your email';
			case 'registration.email.emailValidation': return 'Email is required';
			case 'registration.email.emailInvalid': return 'Please enter a valid email';
			case 'registration.password.passwordText': return 'Password';
			case 'registration.password.passwordHint': return 'Please enter your password';
			case 'registration.password.passwordValidation': return 'Password is required';
			case 'registration.password.passwordShort': return ({required Object minPasswordSize}) => 'Password must be at least ${minPasswordSize} characters';
			case 'registration.password.changePassword.changePasswordText': return 'Change Password';
			case 'registration.password.changePassword.currentPassword': return 'Current Password';
			case 'registration.password.changePassword.currentPasswordValidator': return 'Please enter your current password';
			case 'registration.password.changePassword.newPassword': return 'New Password';
			case 'registration.password.changePassword.newPasswordValidator': return 'Please enter a new password';
			case 'registration.password.changePassword.resetPasswordButton': return 'Reset Password';
			case 'registration.password.changePassword.confirmNewPassword': return 'Confirm New Password';
			case 'registration.password.changePassword.success': return 'Password successfully changed';
			case 'registration.password.resetPassword.resetPasswordText': return 'Reset Password';
			case 'registration.password.resetPassword.resetPasswordButton': return 'Send Reset link';
			case 'registration.password.resetPassword.resetPasswordCaption': return 'Enter your email address and we\'ll send you a link to reset your password.';
			case 'registration.password.resetPassword.resetPasswordSuccess': return 'Password reset email sent. Please check your inbox.';
			case 'registration.password.resetPassword.resetPasswordError': return 'Error sending password reset email';
			case 'registration.password.resetPassword.backToSignIn': return 'Back to Sign In';
			case 'registration.confirmPassword.confirmPasswordText': return 'Confirm Password';
			case 'registration.confirmPassword.confirmPasswordHint': return 'Re-enter your password';
			case 'registration.confirmPassword.confirmPasswordValidation': return 'Re-enter password is required';
			case 'registration.confirmPassword.confirmPasswordMismatch': return 'Passwords do not match';
			case 'registration.signUp.signUpText': return 'Create Account';
			case 'registration.signUp.signUpCaption': return 'Join Dream Journal today';
			case 'registration.signUp.alreadyHaveAccount': return 'Already have an account?';
			case 'registration.signIn.signInText': return 'Sign In';
			case 'registration.signIn.forgotPassword': return 'Forgot Password?';
			case 'registration.signOut.signOutText': return 'Sign Out';
			case 'dreamEntry.newDream': return 'New Dream';
			case 'dreamEntry.saveDream': return 'Save Dream';
			case 'dreamEntry.dreamTitle': return 'Dream Title';
			case 'dreamEntry.dreamTitleHint': return 'Please enter a title for your dream';
			case 'dreamEntry.yourDream': return 'Your Dream';
			case 'dreamEntry.tags.tags': return 'Tags';
			case 'dreamEntry.tags.Happiness': return 'happiness';
			case 'dreamEntry.tags.Anxiety': return 'anxiety';
			case 'dreamEntry.tags.Fear': return 'fear';
			case 'dreamEntry.tags.Joy': return 'joy';
			case 'dreamEntry.tags.Anger': return 'anger';
			case 'dreamEntry.tags.Confusion': return 'confusion';
			case 'dreamEntry.tags.Love': return 'love';
			case 'dreamEntry.tags.Peace': return 'peace';
			case 'dreamEntry.tags.Sadness': return 'sadness';
			case 'dreamEntry.tags.Excitement': return 'excitement';
			case 'dreamEntry.moodRating': return 'Mood Rating';
			case 'dreamEntry.failedToSaveDream': return 'Failed to save dream';
			case 'dreamEntry.dreamDetails.addDetails': return 'Add Details';
			case 'dreamEntry.dreamDetails.addTags': return 'Add tags';
			case 'dreamEntry.dreamDetails.moodRating': return 'Mood Rating';
			case 'dreamEntry.dreamDetails.confirmButton': return 'Confirm';
			case 'dreamEntry.dreamForm.record': return 'Record Your Dream';
			case 'dreamEntry.dreamForm.content': return 'Dream Content';
			case 'dreamEntry.dreamForm.contentHint': return 'Please enter your dream content';
			case 'dreamEntry.dreamForm.getInterpretation': return 'Get Interpretation';
			case 'dreamEntry.interpretation.title': return 'Dream Interpretation';
			case 'dreamEntry.interpretation.interpretationText': return 'Interpretation';
			case 'dreamEntry.interpretation.saveButton': return 'Save Interpretation';
			case 'dreamEntry.interpretation.shareButton': return 'Share Interpretation';
			case 'dreamDetail': return 'Dream Description';
			case 'dreamFilterOptions.all': return 'All';
			case 'dreamFilterOptions.week': return 'This Week';
			case 'dreamFilterOptions.month': return 'This Month';
			case 'dreamFilterOptions.favorites': return 'Favorites';
			case 'searchDreams.searchDreams': return 'Search Dreams';
			case 'searchDreams.retryButton': return 'Retry';
			case 'searchDreams.noResults': return 'No dreams found';
			case 'searchDreams.delete': return 'Delete';
			case 'searchDreams.undoButton': return 'Undo';
			case 'dreamHistory.dreamHistory': return 'Dream Journal';
			case 'dreamHistory.noDreams': return 'No dreams recorded';
			case 'dreamHistory.noDreamsCaption': return 'You haven\'t recorded any dreams yet. Start recording your dreams today.';
			case 'profile.profile': return 'Profile';
			case 'profile.username': return 'Username';
			case 'profile.profileNotFound': return 'Profile not found';
			case 'profile.dreamStats': return 'Dream Statistics';
			case 'profile.totalDreams': return 'Total Dreams';
			case 'profile.weeklyDreams': return 'Weekly Dreams';
			case 'profile.completionRate': return 'Completion Rate';
			case 'profile.settings': return 'Settings';
			case 'profile.notifications': return 'Notifications';
			case 'profile.changePassword': return 'Change Password';
			case 'profile.logout': return 'Logout';
			default: return null;
		}
	}
}

