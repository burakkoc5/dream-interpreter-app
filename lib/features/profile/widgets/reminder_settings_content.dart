import 'package:dream/core/utils/reminder_utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/reminder_settings_model.dart';
import '../widgets/reminder_option_card.dart';

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

class _ReminderSettingsContentState extends State<ReminderSettingsContent> {
  ReminderType? selectedType;
  TimeOfDay? selectedCustomTime;

  @override
  void initState() {
    super.initState();
    if (widget.initialSettings != null) {
      selectedType = ReminderType.values.firstWhere(
        (type) => type.name == widget.initialSettings!.type,
        orElse: () => ReminderType.earlyMorning,
      );
      selectedCustomTime = widget.initialSettings?.time != null
          ? TimeOfDay.fromDateTime(widget.initialSettings!.time)
          : null;
    }
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ReminderOptionCard(
                  type: ReminderType.earlyMorning,
                  icon: Icons.bedtime,
                  title: 'Early morning',
                  subtitle: '6:00 AM',
                  onTap: () =>
                      _handleOptionSelection(ReminderType.earlyMorning),
                  isSelected: selectedType == ReminderType.earlyMorning,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ReminderOptionCard(
                  type: ReminderType.afternoon,
                  icon: Icons.wb_sunny,
                  title: 'Afternoon',
                  subtitle: '2:00 PM',
                  onTap: () => _handleOptionSelection(ReminderType.afternoon),
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
                  title: 'Nighttime',
                  subtitle: '10:00 PM',
                  onTap: () => _handleOptionSelection(ReminderType.nighttime),
                  isSelected: selectedType == ReminderType.nighttime,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ReminderOptionCard(
                  type: ReminderType.custom,
                  icon: Icons.access_time,
                  title: 'Custom',
                  subtitle: 'Set your time',
                  onTap: _handleCustomTimeSelection,
                  isSelected: selectedType == ReminderType.custom,
                ),
              ),
            ],
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: _saveSettings,
              child: const Text('Continue'),
            ),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('Ignore'),
          ),
        ],
      ),
    );
  }
}
