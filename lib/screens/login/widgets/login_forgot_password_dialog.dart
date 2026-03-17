import 'package:flutter/material.dart';
import 'package:time_tracker/screens/login/cubit/login_state.dart';
import 'package:time_tracker/theme/app_theme.dart';
import 'package:time_tracker/widgets/app_toast.dart';

Future<void> showLoginForgotPasswordDialog({
  required BuildContext context,
  required LoginState state,
  required String initialEmail,
  required Future<void> Function(String email) onSubmit,
}) async {
  final emailController = TextEditingController(text: initialEmail);

  await showDialog<void>(
    context: context,
    builder:
        (context) => AlertDialog(
          backgroundColor: AppTheme.cardDark,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: AppTheme.borderDark),
          ),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: AppTheme.primaryAccent.withValues(alpha: 0.1), shape: BoxShape.circle),
                child: const Icon(Icons.lock_reset, color: AppTheme.primaryAccent, size: 24),
              ),
              const SizedBox(width: 12),
              const Text('Reset Password'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enter your email address and we\'ll send you a link to reset your password.',
                style: TextStyle(color: AppTheme.textSecondary, fontSize: 14),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email', prefixIcon: Icon(Icons.email_outlined)),
                keyboardType: TextInputType.emailAddress,
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            ElevatedButton(
              onPressed:
                  state.isSubmitting
                      ? null
                      : () async {
                        final email = emailController.text.trim();
                        if (email.isEmpty || !email.contains('@')) {
                          AppToast.show(context, 'Please enter a valid email', type: AppToastType.error);
                          return;
                        }

                        await onSubmit(email);
                        if (context.mounted) {
                          Navigator.pop(context);
                        }
                      },
              child:
                  state.isSubmitting
                      ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2, color: AppTheme.primaryDark),
                      )
                      : const Text('Send Reset Link'),
            ),
          ],
        ),
  );
}
