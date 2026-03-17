import 'package:flutter/material.dart';
import 'package:time_tracker/theme/app_theme.dart';

class LoginDesktopLayout extends StatelessWidget {
  const LoginDesktopLayout({super.key, required this.size, required this.form});

  final Size size;
  final Widget form;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 400,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.primaryAccent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.access_time_filled, size: 48, color: AppTheme.primaryAccent),
              ),
              const SizedBox(height: 32),
              Text(
                'Time Tracker',
                style: Theme.of(
                  context,
                ).textTheme.displayMedium?.copyWith(color: AppTheme.textPrimary, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 16),
              Text(
                'Track your time efficiently.\nManage projects, clients, and teams\nall in one place.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppTheme.textSecondary, height: 1.6),
              ),
              const SizedBox(height: 40),
              const _LoginFeatureItem(icon: Icons.schedule, text: 'Track time with ease'),
              const SizedBox(height: 16),
              const _LoginFeatureItem(icon: Icons.folder_outlined, text: 'Organize by projects'),
              const SizedBox(height: 16),
              const _LoginFeatureItem(icon: Icons.analytics_outlined, text: 'Detailed reports'),
            ],
          ),
        ),
        const SizedBox(width: 100),
        form,
      ],
    );
  }
}

class LoginMobileLayout extends StatelessWidget {
  const LoginMobileLayout({super.key, required this.form});

  final Widget form;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.primaryAccent.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Icon(Icons.access_time_filled, size: 40, color: AppTheme.primaryAccent),
        ),
        const SizedBox(height: 24),
        Text(
          'Time Tracker',
          style: Theme.of(
            context,
          ).textTheme.displaySmall?.copyWith(color: AppTheme.textPrimary, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        Text(
          'Track your time efficiently',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.textSecondary),
        ),
        const SizedBox(height: 40),
        form,
      ],
    );
  }
}

class _LoginFeatureItem extends StatelessWidget {
  const _LoginFeatureItem({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppTheme.successAccent.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 20, color: AppTheme.successAccent),
        ),
        const SizedBox(width: 12),
        Text(text, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 14)),
      ],
    );
  }
}
