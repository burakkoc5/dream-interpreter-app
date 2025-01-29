import 'package:dream/core/routing/app_route_names.dart';
import 'package:dream/features/profile/application/profile_cubit.dart';
import 'package:dream/features/profile/presentation/utils/profile_translations.dart';
import 'package:dream/features/profile/presentation/widgets/profile_header_widget.dart';
import 'package:dream/features/profile/presentation/widgets/stats_card_widget.dart';
import 'package:dream/i18n/strings.g.dart';
import 'package:dream/shared/widgets/app_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class ProfileContent extends StatelessWidget {
  const ProfileContent({super.key, required this.profile});

  final dynamic profile;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ListView(
      padding: EdgeInsets.fromLTRB(
          16, 8, 16, MediaQuery.of(context).padding.bottom + 80),
      children: [
        EditableProfileHeader(
          profile: profile,
          onDisplayNameChanged: (newName) {
            context.read<ProfileCubit>().updateDisplayName(newName);
            AppToast.showSuccess(
              context,
              title: t.core.success,
              description: t.profile.displayNameUpdated,
            );
          },
        ),
        const SizedBox(height: 16),
        const StatsCardWidget(),
        const SizedBox(height: 16),
        if (profile.gender != null ||
            profile.horoscope != null ||
            profile.occupation != null ||
            profile.relationshipStatus != null ||
            profile.birthDate != null ||
            (profile.interests?.isNotEmpty ?? false))
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        t.profile.personalization.title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.edit,
                          size: 20,
                          color: theme.colorScheme.primary,
                        ),
                        onPressed: () {
                          context.push(AppRoute.personalization);
                        },
                        visualDensity: VisualDensity.compact,
                        style: IconButton.styleFrom(
                          backgroundColor:
                              theme.colorScheme.primary.withValues(alpha: 0.1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerHighest
                          .withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        if (profile.gender != null)
                          _buildInfoTile(
                            context,
                            t.profile.personalization.gender,
                            ProfileTranslations.getTranslatedGender(
                                profile.gender!),
                            Icons.person,
                            showDivider: profile.birthDate != null ||
                                profile.horoscope != null ||
                                profile.occupation != null ||
                                profile.relationshipStatus != null,
                          ),
                        if (profile.birthDate != null)
                          _buildInfoTile(
                            context,
                            t.profile.personalization.birthDate,
                            DateFormat('dd/MM/yyyy').format(profile.birthDate),
                            Icons.calendar_today,
                            showDivider: profile.horoscope != null ||
                                profile.occupation != null ||
                                profile.relationshipStatus != null,
                          ),
                        if (profile.horoscope != null)
                          _buildInfoTile(
                            context,
                            t.profile.personalization.horoscope,
                            ProfileTranslations.getTranslatedHoroscope(
                                profile.horoscope!),
                            Icons.auto_awesome,
                            showDivider: profile.occupation != null ||
                                profile.relationshipStatus != null,
                          ),
                        if (profile.occupation != null)
                          _buildInfoTile(
                            context,
                            t.profile.personalization.occupation,
                            ProfileTranslations.getTranslatedOccupation(
                                profile.occupation!),
                            Icons.work,
                            showDivider: profile.relationshipStatus != null,
                          ),
                        if (profile.relationshipStatus != null)
                          _buildInfoTile(
                            context,
                            t.profile.personalization.relationshipStatus,
                            ProfileTranslations.getTranslatedRelationshipStatus(
                                profile.relationshipStatus!),
                            Icons.favorite,
                            showDivider: false,
                          ),
                      ],
                    ),
                  ),
                  if (profile.interests?.isNotEmpty ?? false) ...[
                    const SizedBox(height: 16),
                    Text(
                      t.profile.personalization.interests,
                      style: theme.textTheme.titleSmall?.copyWith(
                        color:
                            theme.colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainerHighest
                            .withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color:
                              theme.colorScheme.outline.withValues(alpha: 0.2),
                          width: 1,
                        ),
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          for (final interest in profile.interests!)
                            Chip(
                              label: Text(
                                ProfileTranslations.getTranslatedInterest(
                                    interest),
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: colorScheme.onSurface,
                                ),
                              ),
                              backgroundColor: colorScheme.surface,
                              side: BorderSide(
                                color: theme.colorScheme.outline
                                    .withValues(alpha: 0.2),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildInfoTile(
    BuildContext context,
    String label,
    String value,
    IconData icon, {
    bool showDivider = true,
  }) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  size: 20,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color:
                            theme.colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                    Text(
                      value,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            thickness: 1,
            color: theme.colorScheme.outline.withValues(alpha: 0.1),
          ),
      ],
    );
  }
}
