import 'package:dream/features/profile/presentation/widgets/settings_item_widget.dart';
import 'package:dream/features/profile/presentation/widgets/stats_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skeletonizer/skeletonizer.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: ListView(
        padding: EdgeInsets.fromLTRB(
            16, 8, 16, MediaQuery.of(context).padding.bottom + 80),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    child: Skeleton.ignore(
                      child: SvgPicture.asset('assets/avatars/avatar1.svg'),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'displayName',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text('email'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          const StatsCardWidget(),
          const SizedBox(height: 16),
          const SettingsItemWidget(),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
