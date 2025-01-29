import 'package:flutter/material.dart';
import 'dart:ui';
import '../utils/share_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dream/features/profile/application/profile_cubit.dart';

class DreamCard extends StatefulWidget {
  final String title;
  final String dreamContent;
  final String interpretation;
  final DateTime date;
  final VoidCallback onTap;
  final VoidCallback? onDelete;
  final bool isGlassmorphic;
  final int moodRating;
  final bool isFavourite;
  final VoidCallback onFavoriteToggle;

  const DreamCard({
    super.key,
    required this.title,
    required this.dreamContent,
    required this.interpretation,
    required this.date,
    required this.onTap,
    required this.moodRating,
    required this.isFavourite,
    required this.onFavoriteToggle,
    this.onDelete,
    this.isGlassmorphic = true,
  });

  @override
  State<DreamCard> createState() => _DreamCardState();
}

class _DreamCardState extends State<DreamCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _glowAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.98).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
    _glowAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) => Transform.scale(
        scale: _scaleAnimation.value,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.primary.withValues(alpha: 0.1),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
              if (_isPressed)
                BoxShadow(
                  color: theme.colorScheme.primary
                      .withValues(alpha: 0.2 * _glowAnimation.value),
                  blurRadius: 20,
                  spreadRadius: 4 * _glowAnimation.value,
                ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: widget.isGlassmorphic ? 8 : 0,
                sigmaY: widget.isGlassmorphic ? 8 : 0,
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTapDown: (_) {
                    setState(() => _isPressed = true);
                    _controller.forward();
                  },
                  onTapUp: (_) {
                    setState(() => _isPressed = false);
                    _controller.reverse();
                  },
                  onTapCancel: () {
                    setState(() => _isPressed = false);
                    _controller.reverse();
                  },
                  onTap: widget.onTap,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          theme.cardTheme.color?.withValues(
                                  alpha: widget.isGlassmorphic ? 0.7 : 0.95) ??
                              Colors.white.withValues(
                                  alpha: widget.isGlassmorphic ? 0.7 : 0.95),
                          theme.cardTheme.color?.withValues(
                                  alpha: widget.isGlassmorphic ? 0.5 : 0.85) ??
                              Colors.white.withValues(
                                  alpha: widget.isGlassmorphic ? 0.5 : 0.85),
                        ],
                      ),
                      border: Border.all(
                        color: theme.colorScheme.primary
                            .withValues(alpha: _isPressed ? 0.2 : 0.1),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Stack(
                      children: [
                        if (_isPressed)
                          Positioned.fill(
                            child: CustomPaint(
                              painter: StarfieldPainter(
                                color: theme.colorScheme.primary.withValues(
                                    alpha: 0.1 * _glowAnimation.value),
                              ),
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.nights_stay,
                                    color: theme.colorScheme.primary
                                        .withValues(alpha: 0.6),
                                    size: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      widget.title.isEmpty
                                          ? 'Untitled'
                                          : widget.title,
                                      style:
                                          theme.textTheme.titleMedium?.copyWith(
                                        color: theme.colorScheme.onSurface,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  _buildDateAndMoodSection(theme),
                                  _buildActionButtons(theme),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDateAndMoodSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDateRow(theme),
        const SizedBox(height: 4),
        _buildMoodRatingRow(theme),
      ],
    );
  }

  Widget _buildDateRow(ThemeData theme) {
    return Row(
      children: [
        Icon(
          Icons.calendar_today,
          size: 16,
          color: theme.colorScheme.primary.withValues(alpha: 0.6),
        ),
        const SizedBox(width: 4),
        Text(
          _formatDate(widget.date),
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }

  Widget _buildMoodRatingRow(ThemeData theme) {
    return Row(
      children: [
        Icon(
          Icons.mood,
          size: 16,
          color: theme.colorScheme.primary.withValues(alpha: 0.6),
        ),
        const SizedBox(width: 4),
        Row(
          children: List.generate(5, (index) {
            return Icon(
              index < widget.moodRating ? Icons.star : Icons.star_border,
              size: 12,
              color: theme.colorScheme.primary.withValues(alpha: 0.6),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildActionButtons(ThemeData theme) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildFavoriteButton(theme),
        const SizedBox(width: 8),
        _buildShareButton(theme),
        if (widget.onDelete != null) ...[
          const SizedBox(width: 8),
          _buildDeleteButton(theme),
        ],
      ],
    );
  }

  Widget _buildFavoriteButton(ThemeData theme) {
    return IconButton(
      icon: Icon(
        widget.isFavourite ? Icons.favorite : Icons.favorite_border,
        color: widget.isFavourite
            ? Colors.red
            : theme.colorScheme.primary.withValues(alpha: 0.8),
        size: 20,
      ),
      onPressed: widget.onFavoriteToggle,
      padding: const EdgeInsets.all(8),
      constraints: const BoxConstraints(),
    );
  }

  Widget _buildShareButton(ThemeData theme) {
    return IconButton(
      icon: Icon(
        Icons.share_outlined,
        color: theme.colorScheme.primary.withValues(alpha: 0.8),
        size: 20,
      ),
      onPressed: () => _shareDream(
        widget.title,
        widget.dreamContent,
        widget.interpretation,
      ),
      padding: const EdgeInsets.all(8),
      constraints: const BoxConstraints(),
    );
  }

  Widget _buildDeleteButton(ThemeData theme) {
    return IconButton(
      icon: Icon(
        Icons.delete_outline,
        color: theme.colorScheme.error.withValues(alpha: 0.8),
        size: 20,
      ),
      onPressed: widget.onDelete,
      padding: const EdgeInsets.all(8),
      constraints: const BoxConstraints(),
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  Future<void> _shareDream(
    String title,
    String dream,
    String interpretation,
  ) async {
    final profile = context.read<ProfileCubit>().state.profile;
    await ShareUtils.shareDreamAsImage(
      context: context,
      title: title,
      content: dream,
      interpretation: interpretation,
      date: widget.date,
      moodRating: widget.moodRating,
      profile: profile,
    );
  }
}

class StarfieldPainter extends CustomPainter {
  final Color color;
  final int starCount = 50;

  StarfieldPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final random = DateTime.now().millisecondsSinceEpoch;
    final paint = Paint()..color = color;

    for (var i = 0; i < starCount; i++) {
      final x = (random + i * 7) % size.width;
      final y = (random + i * 11) % size.height;
      final radius = ((random + i * 13) % 3) + 1.0;
      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  @override
  bool shouldRepaint(StarfieldPainter oldDelegate) => false;
}
