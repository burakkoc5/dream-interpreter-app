import 'package:dream/core/utils/reminder_utils.dart';
import 'package:dream/i18n/strings.g.dart';
import 'package:dream/shared/widgets/app_toast.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../models/reminder_settings_model.dart';
import 'reminder_option_card.dart';
import 'package:dream/shared/widgets/app_button.dart' as app;

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
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
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
            app.AppButton(
              text: t.profile.reminder.saveButton,
              onPressed: () {
                if (selectedType != null) {
                  _saveSettings();
                  AppToast.showSuccess(
                    context,
                    title: t.core.success,
                    description: t.profile.reminder.savedSuccess,
                  );
                }
              },
              style: app.ButtonStyle.primary,
              isFullWidth: true,
            ),
            const SizedBox(height: 12),
            app.AppButton(
              text: t.profile.reminder.skipButton,
              onPressed: () => context.pop(),
              style: app.ButtonStyle.text,
              isFullWidth: true,
            ),
          ],
        ),
      ),
    );
  }
}
