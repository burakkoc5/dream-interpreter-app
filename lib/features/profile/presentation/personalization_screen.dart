import 'package:dream/core/routing/app_route_names.dart';
import 'package:dream/features/profile/application/profile_cubit.dart';
import 'package:dream/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:dream/features/auth/application/auth_cubit.dart';
import 'package:dream/shared/widgets/app_button.dart' as app;

class PersonalizationScreen extends StatefulWidget {
  const PersonalizationScreen({super.key});

  @override
  State<PersonalizationScreen> createState() => _PersonalizationScreenState();
}

class _PersonalizationScreenState extends State<PersonalizationScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _gender;
  String? _horoscope;
  String? _occupation;
  String? _relationshipStatus;
  DateTime? _birthDate;
  List<String> _selectedInterests = [];

  final Map<String, String> _genderMap = {
    'male': t.profile.personalization.genderOptions.male,
    'female': t.profile.personalization.genderOptions.female,
    'other': t.profile.personalization.genderOptions.other,
    'preferNotToSay': t.profile.personalization.genderOptions.preferNotToSay,
  };

  final Map<String, String> _horoscopeMap = {
    'Aries': t.profile.personalization.horoscopeOptions.aries,
    'Taurus': t.profile.personalization.horoscopeOptions.taurus,
    'Gemini': t.profile.personalization.horoscopeOptions.gemini,
    'Cancer': t.profile.personalization.horoscopeOptions.cancer,
    'Leo': t.profile.personalization.horoscopeOptions.leo,
    'Virgo': t.profile.personalization.horoscopeOptions.virgo,
    'Libra': t.profile.personalization.horoscopeOptions.libra,
    'Scorpio': t.profile.personalization.horoscopeOptions.scorpio,
    'Sagittarius': t.profile.personalization.horoscopeOptions.sagittarius,
    'Capricorn': t.profile.personalization.horoscopeOptions.capricorn,
    'Aquarius': t.profile.personalization.horoscopeOptions.aquarius,
    'Pisces': t.profile.personalization.horoscopeOptions.pisces,
  };

  final Map<String, String> _relationshipMap = {
    'Single': t.profile.personalization.relationshipOptions.single,
    'In Relationship':
        t.profile.personalization.relationshipOptions.inRelationship,
    'Married': t.profile.personalization.relationshipOptions.married,
    'Prefer Not To Say':
        t.profile.personalization.relationshipOptions.preferNotToSay,
  };

  //Occupations
  final Map<String, String> _occupationMap = {
    'Homemaker': t.profile.personalization.occupationOptions.homemaker,
    'Unemployed': t.profile.personalization.occupationOptions.unemployed,
    'Job Seeker': t.profile.personalization.occupationOptions.jobSeeker,
    'Student': t.profile.personalization.occupationOptions.student,
    'Academic': t.profile.personalization.occupationOptions.academic,
    'Self Employed': t.profile.personalization.occupationOptions.selfEmployed,
    'Public Sector': t.profile.personalization.occupationOptions.publicSector,
    'Private Sector': t.profile.personalization.occupationOptions.privateSector,
    'Retired': t.profile.personalization.occupationOptions.retired,
  };

  //Interests
  final Map<String, String> _interestMap = {
    'Spirituality': t.profile.personalization.interestOptions.spirituality,
    'Meditation': t.profile.personalization.interestOptions.meditation,
    'Psychology': t.profile.personalization.interestOptions.psychology,
    'Self Improvement':
        t.profile.personalization.interestOptions.selfImprovement,
    'Art': t.profile.personalization.interestOptions.art,
    'Music': t.profile.personalization.interestOptions.music,
    'Travel': t.profile.personalization.interestOptions.travel,
    'Nature': t.profile.personalization.interestOptions.nature,
    'Technology': t.profile.personalization.interestOptions.technology,
    'Science': t.profile.personalization.interestOptions.science,
    'Sports': t.profile.personalization.interestOptions.sports,
    'Cooking': t.profile.personalization.interestOptions.cooking,
    'Reading': t.profile.personalization.interestOptions.reading,
    'Writing': t.profile.personalization.interestOptions.writing,
    'Photography': t.profile.personalization.interestOptions.photography,
  };

  @override
  void initState() {
    super.initState();
    final profile = context.read<ProfileCubit>().state.profile;
    if (profile != null) {
      setState(() {
        _gender = profile.gender;
        _horoscope = profile.horoscope;
        _occupation = profile.occupation;
        _relationshipStatus = profile.relationshipStatus;
        _birthDate = profile.birthDate;
        _selectedInterests = List<String>.from(profile.interests);
      });
    }
  }

  List<String> get _genderOptions => _genderMap.keys.toList();

  String _getGenderDisplay(String key) => _genderMap[key] ?? key;

  List<String> get _horoscopeOptions => _horoscopeMap.keys.toList();

  String _getHoroscopeDisplay(String key) => _horoscopeMap[key] ?? key;

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _birthDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _birthDate) {
      setState(() {
        _birthDate = picked;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final profileCubit = context.read<ProfileCubit>();
      final userId = context.read<AuthCubit>().state.user?.id;

      if (userId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(t.core.errors.tryAgain),
            action: SnackBarAction(
              label: t.core.errors.tryAgain,
              onPressed: _submitForm,
            ),
          ),
        );
        return;
      }

      _updateProfileAndNavigate(profileCubit, userId);
    }
  }

  Future<void> _updateProfileAndNavigate(
      ProfileCubit profileCubit, String userId) async {
    try {
      await profileCubit.updatePersonalInfo(
        gender: _gender,
        horoscope: _horoscope,
        occupation: _occupation,
        relationshipStatus: _relationshipStatus,
        birthDate: _birthDate,
        interests: _selectedInterests,
        hasCompletedPersonalization: true,
      );

      // Wait for a short duration to ensure Firestore has updated
      await Future.delayed(const Duration(milliseconds: 500));

      if (mounted) {
        context.go(AppRoute.dreamEntry);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(t.core.errors.tryAgain),
            action: SnackBarAction(
              label: t.core.errors.tryAgain,
              onPressed: _submitForm,
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Theme(
      data: Theme.of(context).copyWith(
        popupMenuTheme: PopupMenuThemeData(
          color: colorScheme.surface,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            t.profile.personalization.title,
            style: theme.textTheme.titleMedium,
          ),
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                t.profile.personalization.description,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color:
                      theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.8),
                ),
              ),
              const SizedBox(height: 24),

              // Gender Selection
              Container(
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest
                      .withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButtonFormField<String>(
                  value: _gender,
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: colorScheme.primary,
                  ),
                  dropdownColor: colorScheme.surface,
                  decoration: InputDecoration(
                    labelText: t.profile.personalization.gender,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: colorScheme.outline.withValues(alpha: 0.5),
                        width: 1.5,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: colorScheme.outline.withValues(alpha: 0.5),
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: colorScheme.outline.withValues(alpha: 0.5),
                        width: 1.5,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: colorScheme.error,
                        width: 1.5,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: colorScheme.error,
                        width: 1.5,
                      ),
                    ),
                    contentPadding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
                    labelStyle: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.primary,
                    ),
                  ),
                  menuMaxHeight: 300,
                  items: _genderOptions.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        _getGenderDisplay(value),
                        style: theme.textTheme.bodyMedium,
                      ),
                    );
                  }).toList(),
                  onChanged: (value) => setState(() => _gender = value),
                ),
              ),
              const SizedBox(height: 16),

              // Birth Date
              Container(
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest
                      .withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextFormField(
                  readOnly: true,
                  onTap: _selectDate,
                  controller: TextEditingController(
                    text: _birthDate == null
                        ? ''
                        : DateFormat('dd/MM/yyyy').format(_birthDate!),
                  ),
                  style: theme.textTheme.bodyMedium,
                  decoration: InputDecoration(
                    labelText: t.profile.personalization.birthDate,
                    hintText: t.profile.personalization.selectBirthDate,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: colorScheme.outline.withValues(alpha: 0.5),
                        width: 1.5,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: colorScheme.outline.withValues(alpha: 0.5),
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: colorScheme.outline.withValues(alpha: 0.5),
                        width: 1.5,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: colorScheme.error,
                        width: 1.5,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: colorScheme.error,
                        width: 1.5,
                      ),
                    ),
                    contentPadding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
                    labelStyle: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.primary,
                    ),
                    suffixIcon: Icon(
                      Icons.calendar_today,
                      color: colorScheme.primary,
                      size: 20,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Horoscope
              Container(
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest
                      .withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButtonFormField<String>(
                  value: _horoscope,
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: colorScheme.primary,
                  ),
                  dropdownColor: colorScheme.surface,
                  decoration: InputDecoration(
                    labelText: t.profile.personalization.horoscope,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: colorScheme.outline.withValues(alpha: 0.5),
                        width: 1.5,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: colorScheme.outline.withValues(alpha: 0.5),
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: colorScheme.outline.withValues(alpha: 0.5),
                        width: 1.5,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: colorScheme.error,
                        width: 1.5,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: colorScheme.error,
                        width: 1.5,
                      ),
                    ),
                    contentPadding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
                    labelStyle: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.primary,
                    ),
                  ),
                  menuMaxHeight: 300,
                  items: _horoscopeOptions.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        _getHoroscopeDisplay(value),
                        style: theme.textTheme.bodyMedium,
                      ),
                    );
                  }).toList(),
                  onChanged: (value) => setState(() => _horoscope = value),
                ),
              ),
              const SizedBox(height: 16),

              // Occupation
              Container(
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest
                      .withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButtonFormField<String>(
                  value: _occupation,
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: colorScheme.primary,
                  ),
                  dropdownColor: colorScheme.surface,
                  decoration: InputDecoration(
                    labelText: t.profile.personalization.occupation,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: colorScheme.outline.withValues(alpha: 0.5),
                        width: 1.5,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: colorScheme.outline.withValues(alpha: 0.5),
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: colorScheme.outline.withValues(alpha: 0.5),
                        width: 1.5,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: colorScheme.error,
                        width: 1.5,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: colorScheme.error,
                        width: 1.5,
                      ),
                    ),
                    contentPadding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
                    labelStyle: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.primary,
                    ),
                  ),
                  menuMaxHeight: 300,
                  items: _occupationMap.entries.map((entry) {
                    return DropdownMenuItem<String>(
                      value: entry.key,
                      child: Text(
                        entry.value,
                        style: theme.textTheme.bodyMedium,
                      ),
                    );
                  }).toList(),
                  onChanged: (value) => setState(() => _occupation = value),
                ),
              ),
              const SizedBox(height: 16),

              // Relationship Status
              Container(
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest
                      .withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButtonFormField<String>(
                  value: _relationshipStatus,
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: colorScheme.primary,
                  ),
                  dropdownColor: colorScheme.surface,
                  decoration: InputDecoration(
                    labelText: t.profile.personalization.relationshipStatus,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: colorScheme.outline.withValues(alpha: 0.5),
                        width: 1.5,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: colorScheme.outline.withValues(alpha: 0.5),
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: colorScheme.outline.withValues(alpha: 0.5),
                        width: 1.5,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: colorScheme.error,
                        width: 1.5,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: colorScheme.error,
                        width: 1.5,
                      ),
                    ),
                    contentPadding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
                    labelStyle: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.primary,
                    ),
                  ),
                  menuMaxHeight: 300,
                  items: _relationshipMap.entries.map((entry) {
                    return DropdownMenuItem<String>(
                      value: entry.key,
                      child: Text(
                        entry.value,
                        style: theme.textTheme.bodyMedium,
                      ),
                    );
                  }).toList(),
                  onChanged: (value) =>
                      setState(() => _relationshipStatus = value),
                ),
              ),
              const SizedBox(height: 24),

              // Interests
              Text(
                t.profile.personalization.interests,
                style: theme.textTheme.titleSmall,
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest
                      .withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: colorScheme.outline.withValues(alpha: 0.5),
                    width: 1.5,
                  ),
                ),
                padding: const EdgeInsets.all(12),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _interestMap.entries.map((entry) {
                    final isSelected = _selectedInterests.contains(entry.key);
                    return FilterChip(
                      label: Text(
                        entry.value,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: isSelected ? colorScheme.onPrimary : null,
                        ),
                      ),
                      selected: isSelected,
                      selectedColor: colorScheme.primary,
                      backgroundColor: colorScheme.surface,
                      checkmarkColor: colorScheme.onPrimary,
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            _selectedInterests.add(entry.key);
                          } else {
                            _selectedInterests.remove(entry.key);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 32),

              app.AppButton(
                text: t.profile.personalization.submit,
                onPressed: _submitForm,
                style: app.ButtonStyle.primary,
                isFullWidth: true,
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
