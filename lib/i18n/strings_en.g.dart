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
	String get success => 'Success';
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
	String get discardDream => 'Discard';
	String get shareDream => 'Share';
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
	String get selectTag => 'Select Tag';
	String get tags => 'Tags';
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
	String get dreamDeleted => 'Dream deleted';
}

// Path: dreamHistory
class TranslationsDreamHistoryEn {
	TranslationsDreamHistoryEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get dreamHistory => 'Past Dreams';
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
	String get email => 'Email';
	String get notifications => 'Notifications';
	String get settings => 'Settings';
	String get logout => 'Logout';
	String get changePassword => 'Change Password';
	String get profileNotFound => 'Profile not found';
	String get closeBackgroundAnimation => 'Close Background Animation';
	late final TranslationsProfilePersonalizationEn personalization = TranslationsProfilePersonalizationEn._(_root);
	String get dreamStats => 'Dream Statistics';
	String get currentStreak => 'Current Streak';
	String get longestStreak => 'Longest Streak';
	String get totalDreams => 'Total Dreams';
	String get weeklyDreams => 'Weekly Dreams';
	String get completionRate => 'Completion Rate';
	String get language => 'Language';
	String get english => 'English';
	String get turkish => 'Turkish';
	String get german => 'German';
	late final TranslationsProfileReminderEn reminder = TranslationsProfileReminderEn._(_root);
}

// Path: core.mode
class TranslationsCoreModeEn {
	TranslationsCoreModeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get systemMode => 'System';
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
	String get unknown => 'Email or password is incorrect';
	String get tryAgain => 'Please try again';
	String get userNotAuthenticated => 'User not authenticated';
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
	String get noAttemptsLeft => 'No attempts left for today. Watch an ad to interpret more dreams.';
	String get watchAdError => 'Please watch the ad to interpret more dreams today.';
	String get dreamSaved => 'Dream saved successfully';
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

// Path: profile.personalization
class TranslationsProfilePersonalizationEn {
	TranslationsProfilePersonalizationEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Personalize Your Profile';
	String get description => 'Help us understand you better to provide more personalized dream interpretations.';
	String get gender => 'Gender';
	String get birthDate => 'Birth Date';
	String get selectBirthDate => 'Select Birth Date';
	String get horoscope => 'Horoscope';
	String get occupation => 'Occupation';
	late final TranslationsProfilePersonalizationOccupationOptionsEn occupationOptions = TranslationsProfilePersonalizationOccupationOptionsEn._(_root);
	String get relationshipStatus => 'Relationship Status';
	String get interests => 'Your Interests';
	String get submit => 'Save & Continue';
	late final TranslationsProfilePersonalizationGenderOptionsEn genderOptions = TranslationsProfilePersonalizationGenderOptionsEn._(_root);
	late final TranslationsProfilePersonalizationHoroscopeOptionsEn horoscopeOptions = TranslationsProfilePersonalizationHoroscopeOptionsEn._(_root);
	late final TranslationsProfilePersonalizationRelationshipOptionsEn relationshipOptions = TranslationsProfilePersonalizationRelationshipOptionsEn._(_root);
	late final TranslationsProfilePersonalizationInterestOptionsEn interestOptions = TranslationsProfilePersonalizationInterestOptionsEn._(_root);
}

// Path: profile.reminder
class TranslationsProfileReminderEn {
	TranslationsProfileReminderEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get setTime => 'Set dream reminder time';
	String get chooseTime => 'Choose when you want to be reminded';
	String get description => 'We\'ll send you a notification to help you remember your dreams';
	String get earlyMorning => 'Early morning';
	String get earlyMorningTime => '6:00 AM';
	String get afternoon => 'Afternoon';
	String get afternoonTime => '2:00 PM';
	String get nighttime => 'Nighttime';
	String get nighttimeTime => '10:00 PM';
	String get custom => 'Custom';
	String get setCustomTime => 'Set your time';
	String get saveButton => 'Save Reminder';
	String get skipButton => 'Skip for now';
	String get savedSuccess => 'Reminder settings saved successfully';
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

// Path: profile.personalization.occupationOptions
class TranslationsProfilePersonalizationOccupationOptionsEn {
	TranslationsProfilePersonalizationOccupationOptionsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get homemaker => 'Homemaker';
	String get unemployed => 'Unemployed';
	String get jobSeeker => 'Job Seeker';
	String get student => 'Student';
	String get academic => 'Academic';
	String get selfEmployed => 'Self-Employed';
	String get publicSector => 'Public Sector';
	String get privateSector => 'Private Sector';
	String get retired => 'Retired';
}

// Path: profile.personalization.genderOptions
class TranslationsProfilePersonalizationGenderOptionsEn {
	TranslationsProfilePersonalizationGenderOptionsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get male => 'Male';
	String get female => 'Female';
	String get other => 'Other';
	String get preferNotToSay => 'Prefer not to say';
}

// Path: profile.personalization.horoscopeOptions
class TranslationsProfilePersonalizationHoroscopeOptionsEn {
	TranslationsProfilePersonalizationHoroscopeOptionsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get aries => 'Aries';
	String get taurus => 'Taurus';
	String get gemini => 'Gemini';
	String get cancer => 'Cancer';
	String get leo => 'Leo';
	String get virgo => 'Virgo';
	String get libra => 'Libra';
	String get scorpio => 'Scorpio';
	String get sagittarius => 'Sagittarius';
	String get capricorn => 'Capricorn';
	String get aquarius => 'Aquarius';
	String get pisces => 'Pisces';
}

// Path: profile.personalization.relationshipOptions
class TranslationsProfilePersonalizationRelationshipOptionsEn {
	TranslationsProfilePersonalizationRelationshipOptionsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get single => 'Single';
	String get inRelationship => 'In a relationship';
	String get married => 'Married';
	String get preferNotToSay => 'Prefer not to say';
}

// Path: profile.personalization.interestOptions
class TranslationsProfilePersonalizationInterestOptionsEn {
	TranslationsProfilePersonalizationInterestOptionsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get spirituality => 'Spirituality';
	String get meditation => 'Meditation';
	String get psychology => 'Psychology';
	String get selfImprovement => 'Self-improvement';
	String get art => 'Art';
	String get music => 'Music';
	String get travel => 'Travel';
	String get nature => 'Nature';
	String get technology => 'Technology';
	String get science => 'Science';
	String get sports => 'Sports';
	String get cooking => 'Cooking';
	String get reading => 'Reading';
	String get writing => 'Writing';
	String get photography => 'Photography';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on Translations {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'core.appName': return 'Dream Journal';
			case 'core.mode.systemMode': return 'System';
			case 'core.mode.darkMode': return 'Dark Mode';
			case 'core.mode.lightMode': return 'Light Mode';
			case 'core.errors.error': return 'Error';
			case 'core.errors.userNotFound': return 'User not found';
			case 'core.errors.wrongPassword': return 'Invalid password';
			case 'core.errors.emailAlreadyInUse': return 'Email is already registered';
			case 'core.errors.invalidEmail': return 'Invalid email format';
			case 'core.errors.weakPassword': return 'Password is too weak';
			case 'core.errors.unknown': return 'Email or password is incorrect';
			case 'core.errors.tryAgain': return 'Please try again';
			case 'core.errors.userNotAuthenticated': return 'User not authenticated';
			case 'core.success': return 'Success';
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
			case 'dreamEntry.discardDream': return 'Discard';
			case 'dreamEntry.shareDream': return 'Share';
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
			case 'dreamEntry.dreamForm.noAttemptsLeft': return 'No attempts left for today. Watch an ad to interpret more dreams.';
			case 'dreamEntry.dreamForm.watchAdError': return 'Please watch the ad to interpret more dreams today.';
			case 'dreamEntry.dreamForm.dreamSaved': return 'Dream saved successfully';
			case 'dreamEntry.interpretation.title': return 'Dream Interpretation';
			case 'dreamEntry.interpretation.interpretationText': return 'Interpretation';
			case 'dreamEntry.interpretation.saveButton': return 'Save Interpretation';
			case 'dreamEntry.interpretation.shareButton': return 'Share Interpretation';
			case 'dreamDetail': return 'Dream Description';
			case 'dreamFilterOptions.selectTag': return 'Select Tag';
			case 'dreamFilterOptions.tags': return 'Tags';
			case 'dreamFilterOptions.all': return 'All';
			case 'dreamFilterOptions.week': return 'This Week';
			case 'dreamFilterOptions.month': return 'This Month';
			case 'dreamFilterOptions.favorites': return 'Favorites';
			case 'searchDreams.searchDreams': return 'Search Dreams';
			case 'searchDreams.retryButton': return 'Retry';
			case 'searchDreams.noResults': return 'No dreams found';
			case 'searchDreams.delete': return 'Delete';
			case 'searchDreams.undoButton': return 'Undo';
			case 'searchDreams.dreamDeleted': return 'Dream deleted';
			case 'dreamHistory.dreamHistory': return 'Past Dreams';
			case 'dreamHistory.noDreams': return 'No dreams recorded';
			case 'dreamHistory.noDreamsCaption': return 'You haven\'t recorded any dreams yet. Start recording your dreams today.';
			case 'profile.profile': return 'Profile';
			case 'profile.username': return 'Username';
			case 'profile.email': return 'Email';
			case 'profile.notifications': return 'Notifications';
			case 'profile.settings': return 'Settings';
			case 'profile.logout': return 'Logout';
			case 'profile.changePassword': return 'Change Password';
			case 'profile.profileNotFound': return 'Profile not found';
			case 'profile.closeBackgroundAnimation': return 'Close Background Animation';
			case 'profile.personalization.title': return 'Personalize Your Profile';
			case 'profile.personalization.description': return 'Help us understand you better to provide more personalized dream interpretations.';
			case 'profile.personalization.gender': return 'Gender';
			case 'profile.personalization.birthDate': return 'Birth Date';
			case 'profile.personalization.selectBirthDate': return 'Select Birth Date';
			case 'profile.personalization.horoscope': return 'Horoscope';
			case 'profile.personalization.occupation': return 'Occupation';
			case 'profile.personalization.occupationOptions.homemaker': return 'Homemaker';
			case 'profile.personalization.occupationOptions.unemployed': return 'Unemployed';
			case 'profile.personalization.occupationOptions.jobSeeker': return 'Job Seeker';
			case 'profile.personalization.occupationOptions.student': return 'Student';
			case 'profile.personalization.occupationOptions.academic': return 'Academic';
			case 'profile.personalization.occupationOptions.selfEmployed': return 'Self-Employed';
			case 'profile.personalization.occupationOptions.publicSector': return 'Public Sector';
			case 'profile.personalization.occupationOptions.privateSector': return 'Private Sector';
			case 'profile.personalization.occupationOptions.retired': return 'Retired';
			case 'profile.personalization.relationshipStatus': return 'Relationship Status';
			case 'profile.personalization.interests': return 'Your Interests';
			case 'profile.personalization.submit': return 'Save & Continue';
			case 'profile.personalization.genderOptions.male': return 'Male';
			case 'profile.personalization.genderOptions.female': return 'Female';
			case 'profile.personalization.genderOptions.other': return 'Other';
			case 'profile.personalization.genderOptions.preferNotToSay': return 'Prefer not to say';
			case 'profile.personalization.horoscopeOptions.aries': return 'Aries';
			case 'profile.personalization.horoscopeOptions.taurus': return 'Taurus';
			case 'profile.personalization.horoscopeOptions.gemini': return 'Gemini';
			case 'profile.personalization.horoscopeOptions.cancer': return 'Cancer';
			case 'profile.personalization.horoscopeOptions.leo': return 'Leo';
			case 'profile.personalization.horoscopeOptions.virgo': return 'Virgo';
			case 'profile.personalization.horoscopeOptions.libra': return 'Libra';
			case 'profile.personalization.horoscopeOptions.scorpio': return 'Scorpio';
			case 'profile.personalization.horoscopeOptions.sagittarius': return 'Sagittarius';
			case 'profile.personalization.horoscopeOptions.capricorn': return 'Capricorn';
			case 'profile.personalization.horoscopeOptions.aquarius': return 'Aquarius';
			case 'profile.personalization.horoscopeOptions.pisces': return 'Pisces';
			case 'profile.personalization.relationshipOptions.single': return 'Single';
			case 'profile.personalization.relationshipOptions.inRelationship': return 'In a relationship';
			case 'profile.personalization.relationshipOptions.married': return 'Married';
			case 'profile.personalization.relationshipOptions.preferNotToSay': return 'Prefer not to say';
			case 'profile.personalization.interestOptions.spirituality': return 'Spirituality';
			case 'profile.personalization.interestOptions.meditation': return 'Meditation';
			case 'profile.personalization.interestOptions.psychology': return 'Psychology';
			case 'profile.personalization.interestOptions.selfImprovement': return 'Self-improvement';
			case 'profile.personalization.interestOptions.art': return 'Art';
			case 'profile.personalization.interestOptions.music': return 'Music';
			case 'profile.personalization.interestOptions.travel': return 'Travel';
			case 'profile.personalization.interestOptions.nature': return 'Nature';
			case 'profile.personalization.interestOptions.technology': return 'Technology';
			case 'profile.personalization.interestOptions.science': return 'Science';
			case 'profile.personalization.interestOptions.sports': return 'Sports';
			case 'profile.personalization.interestOptions.cooking': return 'Cooking';
			case 'profile.personalization.interestOptions.reading': return 'Reading';
			case 'profile.personalization.interestOptions.writing': return 'Writing';
			case 'profile.personalization.interestOptions.photography': return 'Photography';
			case 'profile.dreamStats': return 'Dream Statistics';
			case 'profile.currentStreak': return 'Current Streak';
			case 'profile.longestStreak': return 'Longest Streak';
			case 'profile.totalDreams': return 'Total Dreams';
			case 'profile.weeklyDreams': return 'Weekly Dreams';
			case 'profile.completionRate': return 'Completion Rate';
			case 'profile.language': return 'Language';
			case 'profile.english': return 'English';
			case 'profile.turkish': return 'Turkish';
			case 'profile.german': return 'German';
			case 'profile.reminder.setTime': return 'Set dream reminder time';
			case 'profile.reminder.chooseTime': return 'Choose when you want to be reminded';
			case 'profile.reminder.description': return 'We\'ll send you a notification to help you remember your dreams';
			case 'profile.reminder.earlyMorning': return 'Early morning';
			case 'profile.reminder.earlyMorningTime': return '6:00 AM';
			case 'profile.reminder.afternoon': return 'Afternoon';
			case 'profile.reminder.afternoonTime': return '2:00 PM';
			case 'profile.reminder.nighttime': return 'Nighttime';
			case 'profile.reminder.nighttimeTime': return '10:00 PM';
			case 'profile.reminder.custom': return 'Custom';
			case 'profile.reminder.setCustomTime': return 'Set your time';
			case 'profile.reminder.saveButton': return 'Save Reminder';
			case 'profile.reminder.skipButton': return 'Skip for now';
			case 'profile.reminder.savedSuccess': return 'Reminder settings saved successfully';
			default: return null;
		}
	}
}

