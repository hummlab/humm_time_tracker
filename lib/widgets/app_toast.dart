import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

enum AppToastType { success, error, info }

class AppToast {
  static void show(
    BuildContext context,
    String message, {
    AppToastType type = AppToastType.info,
    Duration duration = const Duration(milliseconds: 2200),
  }) {
    final messenger = ScaffoldMessenger.of(context);
    final theme = Theme.of(context);
    final media = MediaQuery.of(context);
    final isDesktop = media.size.width > 800;

    final accent = _accentFor(type);
    final icon = _iconFor(type);
    final margin =
        isDesktop
            ? EdgeInsets.only(left: media.size.width * 0.55, right: 24, bottom: 24)
            : const EdgeInsets.fromLTRB(16, 0, 16, 24);

    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: duration,
        backgroundColor: Colors.transparent,
        elevation: 0,
        margin: margin,
        content: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: AppTheme.cardDark.withValues(alpha: 0.95),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: accent.withValues(alpha: 0.45)),
            boxShadow: [
              BoxShadow(color: Colors.black.withValues(alpha: 0.35), blurRadius: 18, offset: const Offset(0, 8)),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, size: 16, color: accent),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  message,
                  style: theme.textTheme.bodyMedium?.copyWith(color: AppTheme.textPrimary, height: 1.2, fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Color _accentFor(AppToastType type) {
    switch (type) {
      case AppToastType.success:
        return AppTheme.successAccent;
      case AppToastType.error:
        return AppTheme.tertiaryAccent;
      case AppToastType.info:
        return AppTheme.primaryAccent;
    }
  }

  static IconData _iconFor(AppToastType type) {
    switch (type) {
      case AppToastType.success:
        return Icons.check_circle_outline;
      case AppToastType.error:
        return Icons.error_outline;
      case AppToastType.info:
        return Icons.info_outline;
    }
  }
}
