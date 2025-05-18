import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:preview_play_ui/tapped.dart';

class ToastEarnETHWidgets extends StatelessWidget {
  const ToastEarnETHWidgets(
    this.message, {
    super.key,
    this.onDismissed,
  });

  final String message;
  final VoidCallback? onDismissed;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Tapped(
        onTap: onDismissed?.call,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFE7F4E8),
              borderRadius: const BorderRadius.all(Radius.circular(18)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.8),
                  offset: const Offset(0, 2),
                  blurRadius: 4,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Row(
              children: [
                // Assets.gif.earnEthAnimation.image(width: 38),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '$message 🎉🎉',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    // style: sty.text.body.copyWith(
                    //   color: sty.colors.textMedium,
                    // ),
                  ),
                ),
              ],
            ),
          ),
        ).animate().slide(begin: const Offset(0, 1), end: const Offset(0, 0)),
      ),
    );
  }
}
