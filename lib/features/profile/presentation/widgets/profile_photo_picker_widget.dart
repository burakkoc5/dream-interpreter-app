import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfilePhotoPickerWidget extends StatelessWidget {
  final String? currentPhotoUrl;
  final Function(String photoUrl) onPhotoSelected;

  const ProfilePhotoPickerWidget({
    super.key,
    this.currentPhotoUrl,
    required this.onPhotoSelected,
  });

  static const _defaultPhotos = [
    'assets/avatars/avatar1.svg',
    'assets/avatars/avatar2.svg',
    'assets/avatars/avatar3.svg',
    'assets/avatars/avatar4.svg',
    'assets/avatars/avatar5.svg',
    'assets/avatars/avatar6.svg',
    'assets/avatars/avatar8.svg',
    'assets/avatars/avatar9.svg',
    'assets/avatars/avatar12.svg',
  ];

  void _showPhotoSelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: _defaultPhotos.length,
        itemBuilder: (context, index) {
          final photo = _defaultPhotos[index];
          return InkWell(
            onTap: () {
              onPhotoSelected(photo);
              Navigator.pop(context);
            },
            child: SvgPicture.asset(
              photo,
              width: 60,
              height: 60,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showPhotoSelector(context),
      child: Stack(
        children: [
          CircleAvatar(
            radius: 50,
            child: currentPhotoUrl != null
                ? SvgPicture.asset(
                    currentPhotoUrl!,
                    fit: BoxFit.cover,
                  )
                : SvgPicture.asset(
                    _defaultPhotos.first,
                    fit: BoxFit.cover,
                  ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.edit,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
