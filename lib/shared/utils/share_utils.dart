import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../widgets/dream_share_card.dart';
import 'package:dream/features/profile/models/profile_model.dart';

class ShareUtils {
  static Future<void> shareDreamAsImage({
    required BuildContext context,
    required String title,
    required String content,
    required String interpretation,
    required DateTime date,
    required int moodRating,
    Profile? profile,
  }) async {
    // Create a GlobalKey to access the RepaintBoundary
    final boundaryKey = GlobalKey();

    // Create a RepaintBoundary widget
    final boundary = RepaintBoundary(
      key: boundaryKey,
      child: Material(
        color: Colors.transparent,
        child: DreamShareCard(
          title: title,
          content: content,
          interpretation: interpretation,
          date: date,
          moodRating: moodRating,
          profile: profile,
        ),
      ),
    );

    // Create a new overlay entry to render the widget
    final overlayState = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (buildContext) => Positioned(
        left: -99999,
        child: SizedBox(
          width: 600,
          child: boundary,
        ),
      ),
    );

    // Add the overlay entry to render the widget
    overlayState.insert(overlayEntry);

    try {
      // Wait for the widget to be rendered
      await Future.delayed(const Duration(milliseconds: 100));

      // Find the RepaintBoundary
      final boundary = boundaryKey.currentContext?.findRenderObject()
          as RenderRepaintBoundary?;
      if (boundary == null) {
        throw Exception('Could not find RepaintBoundary');
      }

      // Convert the widget to an image
      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final bytes = byteData?.buffer.asUint8List();

      if (bytes == null) {
        throw Exception('Could not convert image to bytes');
      }

      // Save the image to a temporary file
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/dream_share.png');
      await file.writeAsBytes(bytes);

      // Share the image
      await Share.shareXFiles(
        [XFile(file.path)],
        text: 'Check out my dream from Dream Journal!',
      );
    } finally {
      // Remove the overlay entry
      overlayEntry.remove();
    }
  }
}
