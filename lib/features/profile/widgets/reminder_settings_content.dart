import 'package:dream/core/utils/reminder_utils.dart';
import 'package:dream/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';
import '../models/reminder_settings_model.dart';
import '../widgets/reminder_option_card.dart';
import 'package:dream/config/theme/theme_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReminderSettingsContent extends StatefulWidget {
  final ReminderSettings? initialSettings;
  final Future<void> Function(ReminderSettings) onSave;

  const ReminderSettingsContent({
    required this.initialSettings,
    required this.onSave,
    super.key,
  });

  @override
  State<ReminderSettingsContent> createState() =>
      _ReminderSettingsContentState();
}

class _ReminderSettingsContentState extends State<ReminderSettingsContent>
    with SingleTickerProviderStateMixin {
  ReminderType? selectedType;
  TimeOfDay? selectedCustomTime;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    if (widget.initialSettings != null) {
      selectedType = ReminderType.values.firstWhere(
        (type) => type.name == widget.initialSettings!.type,
        orElse: () => ReminderType.earlyMorning,
      );
      selectedCustomTime = widget.initialSettings?.time != null
          ? TimeOfDay.fromDateTime(widget.initialSettings!.time)
          : null;
    }

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleOptionSelection(ReminderType type) {
    setState(() => selectedType = type);
  }

  void _showSuccessToast(String message) {
    if (!mounted) return;

    toastification.show(
      autoCloseDuration: const Duration(seconds: 3),
      context: context,
      type: ToastificationType.success,
      style: ToastificationStyle.flat,
      title: Text(t.core.success),
      description: Text(message),
    );
  }

  Future<void> _handleCustomTimeSelection() async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (selectedTime != null) {
      setState(() {
        selectedType = ReminderType.custom;
        selectedCustomTime = selectedTime;
      });
    }
  }

  Future<void> _saveSettings() async {
    if (selectedType == null) return;

    final reminderTime = getTimeForType(selectedType!, selectedCustomTime);
    final newSettings = ReminderSettings(
      type: selectedType!.name,
      time: reminderTime,
      isEnabled: true,
    );
    await widget.onSave(newSettings);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final brightness = MediaQuery.platformBrightnessOf(context);
    final isDarkMode = context.watch<ThemeCubit>().state == ThemeMode.dark ||
        (context.watch<ThemeCubit>().state == ThemeMode.system &&
            brightness == Brightness.dark);

    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              t.profile.reminder.chooseTime,
              style: theme.textTheme.titleLarge?.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w600,
                fontSize: 24,
                height: 1.2,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              t.profile.reminder.description,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.7),
                fontSize: 15,
                height: 1.4,
                letterSpacing: 0.1,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: ReminderOptionCard(
                            type: ReminderType.earlyMorning,
                            icon: Icons.bedtime,
                            title: t.profile.reminder.earlyMorning,
                            subtitle: t.profile.reminder.earlyMorningTime,
                            onTap: () => _handleOptionSelection(
                                ReminderType.earlyMorning),
                            isSelected:
                                selectedType == ReminderType.earlyMorning,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ReminderOptionCard(
                            type: ReminderType.afternoon,
                            icon: Icons.wb_sunny,
                            title: t.profile.reminder.afternoon,
                            subtitle: t.profile.reminder.afternoonTime,
                            onTap: () =>
                                _handleOptionSelection(ReminderType.afternoon),
                            isSelected: selectedType == ReminderType.afternoon,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: ReminderOptionCard(
                            type: ReminderType.nighttime,
                            icon: Icons.nights_stay,
                            title: t.profile.reminder.nighttime,
                            subtitle: t.profile.reminder.nighttimeTime,
                            onTap: () =>
                                _handleOptionSelection(ReminderType.nighttime),
                            isSelected: selectedType == ReminderType.nighttime,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ReminderOptionCard(
                            type: ReminderType.custom,
                            icon: Icons.access_time,
                            title: t.profile.reminder.custom,
                            subtitle: selectedCustomTime?.format(context) ??
                                t.profile.reminder.setCustomTime,
                            onTap: _handleCustomTimeSelection,
                            isSelected: selectedType == ReminderType.custom,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () {
                if (selectedType != null) {
                  _saveSettings();
                  _showSuccessToast(t.profile.reminder.savedSuccess);
                }
              },
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                backgroundColor:
                    theme.colorScheme.primary.withOpacity(isDarkMode ? 0.8 : 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                t.profile.reminder.saveButton,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.onPrimary,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () => context.pop(),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                t.profile.reminder.skipButton,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.primary.withOpacity(0.8),
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
