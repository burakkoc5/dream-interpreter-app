import 'package:dream/core/routing/app_route_names.dart';
import 'package:dream/features/profile/application/profile_cubit.dart';
import 'package:dream/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

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
        _selectedInterests = List<String>.from(profile.interests ?? []);
      });
    }
  }

  List<String> get _genderOptions => [
        t.profile.personalization.genderOptions.male,
        t.profile.personalization.genderOptions.female,
        t.profile.personalization.genderOptions.other,
        t.profile.personalization.genderOptions.preferNotToSay,
      ];

  List<String> get _horoscopeOptions => [
        t.profile.personalization.horoscopeOptions.aries,
        t.profile.personalization.horoscopeOptions.taurus,
        t.profile.personalization.horoscopeOptions.gemini,
        t.profile.personalization.horoscopeOptions.cancer,
        t.profile.personalization.horoscopeOptions.leo,
        t.profile.personalization.horoscopeOptions.virgo,
        t.profile.personalization.horoscopeOptions.libra,
        t.profile.personalization.horoscopeOptions.scorpio,
        t.profile.personalization.horoscopeOptions.sagittarius,
        t.profile.personalization.horoscopeOptions.capricorn,
        t.profile.personalization.horoscopeOptions.aquarius,
        t.profile.personalization.horoscopeOptions.pisces,
      ];

  List<String> get _relationshipOptions => [
        t.profile.personalization.relationshipOptions.single,
        t.profile.personalization.relationshipOptions.inRelationship,
        t.profile.personalization.relationshipOptions.married,
        t.profile.personalization.relationshipOptions.preferNotToSay,
      ];

  List<String> get _interestOptions => [
        t.profile.personalization.interestOptions.spirituality,
        t.profile.personalization.interestOptions.meditation,
        t.profile.personalization.interestOptions.psychology,
        t.profile.personalization.interestOptions.selfImprovement,
        t.profile.personalization.interestOptions.art,
        t.profile.personalization.interestOptions.music,
        t.profile.personalization.interestOptions.travel,
        t.profile.personalization.interestOptions.nature,
        t.profile.personalization.interestOptions.technology,
        t.profile.personalization.interestOptions.science,
        t.profile.personalization.interestOptions.sports,
        t.profile.personalization.interestOptions.cooking,
        t.profile.personalization.interestOptions.reading,
        t.profile.personalization.interestOptions.writing,
        t.profile.personalization.interestOptions.photography,
      ];

  List<String> get _occupationOptions => [
        t.profile.personalization.occupationOptions.homemaker,
        t.profile.personalization.occupationOptions.unemployed,
        t.profile.personalization.occupationOptions.jobSeeker,
        t.profile.personalization.occupationOptions.student,
        t.profile.personalization.occupationOptions.academic,
        t.profile.personalization.occupationOptions.selfEmployed,
        t.profile.personalization.occupationOptions.publicSector,
        t.profile.personalization.occupationOptions.privateSector,
        t.profile.personalization.occupationOptions.retired,
      ];

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
      debugPrint('gender: $_gender');
      debugPrint('horoscope: $_horoscope');
      debugPrint('occupation: $_occupation');
      debugPrint('relationshipStatus: $_relationshipStatus');
      debugPrint('birthDate: $_birthDate');
      debugPrint('interests: $_selectedInterests');

      final profileCubit = context.read<ProfileCubit>();
      final profile = profileCubit.state.profile;

      if (profile == null) {
        debugPrint('PersonalizationScreen: Profile is null, showing error');
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

      _updateProfileAndNavigate(profileCubit);
    }
  }

  Future<void> _updateProfileAndNavigate(ProfileCubit profileCubit) async {
    debugPrint('PersonalizationScreen: Updating profile with new information');
    await profileCubit.updatePersonalInfo(
      gender: _gender,
      horoscope: _horoscope,
      occupation: _occupation,
      relationshipStatus: _relationshipStatus,
      birthDate: _birthDate,
      interests: _selectedInterests,
      hasCompletedPersonalization: true,
    );
    debugPrint('PersonalizationScreen: Submitting form');
    if (mounted) {
      context.go(AppRoute.dreamEntry);
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
                  color: theme.textTheme.bodyMedium?.color?.withOpacity(0.8),
                ),
              ),
              const SizedBox(height: 24),

              // Gender Selection
              Container(
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest.withOpacity(0.5),
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
                        color: colorScheme.outline.withOpacity(0.5),
                        width: 1.5,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: colorScheme.outline.withOpacity(0.5),
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: colorScheme.outline.withOpacity(0.5),
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
                        value,
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
                  color: colorScheme.surfaceContainerHighest.withOpacity(0.5),
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
                        color: colorScheme.outline.withOpacity(0.5),
                        width: 1.5,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: colorScheme.outline.withOpacity(0.5),
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: colorScheme.outline.withOpacity(0.5),
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
                  color: colorScheme.surfaceContainerHighest.withOpacity(0.5),
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
                        color: colorScheme.outline.withOpacity(0.5),
                        width: 1.5,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: colorScheme.outline.withOpacity(0.5),
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: colorScheme.outline.withOpacity(0.5),
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
                        value,
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
                  color: colorScheme.surfaceContainerHighest.withOpacity(0.5),
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
                        color: colorScheme.outline.withOpacity(0.5),
                        width: 1.5,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: colorScheme.outline.withOpacity(0.5),
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: colorScheme.outline.withOpacity(0.5),
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
                  items: _occupationOptions.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
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
                  color: colorScheme.surfaceContainerHighest.withOpacity(0.5),
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
                        color: colorScheme.outline.withOpacity(0.5),
                        width: 1.5,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: colorScheme.outline.withOpacity(0.5),
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: colorScheme.outline.withOpacity(0.5),
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
                  items: _relationshipOptions.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
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
                  color: colorScheme.surfaceContainerHighest.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: colorScheme.outline.withOpacity(0.5),
                    width: 1.5,
                  ),
                ),
                padding: const EdgeInsets.all(12),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _interestOptions.map((interest) {
                    final isSelected = _selectedInterests.contains(interest);
                    return FilterChip(
                      label: Text(
                        interest,
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
                            _selectedInterests.add(interest);
                          } else {
                            _selectedInterests.remove(interest);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 32),

              FilledButton(
                onPressed: _submitForm,
                style: FilledButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  t.profile.personalization.submit,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: colorScheme.onPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
