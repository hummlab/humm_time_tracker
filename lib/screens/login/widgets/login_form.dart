import 'package:flutter/material.dart';
import 'package:time_tracker/screens/login/cubit/login_state.dart';
import 'package:time_tracker/theme/app_theme.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required this.state,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.switchController,
    required this.switchFadeAnimation,
    required this.switchSlideAnimation,
    required this.switchScaleAnimation,
    required this.onSubmit,
    required this.onToggleMode,
    required this.onToggleObscurePassword,
    required this.onForgotPassword,
  });

  final LoginState state;
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final Listenable switchController;
  final Animation<double> switchFadeAnimation;
  final Animation<Offset> switchSlideAnimation;
  final Animation<double> switchScaleAnimation;
  final VoidCallback onSubmit;
  final VoidCallback onToggleMode;
  final VoidCallback onToggleObscurePassword;
  final VoidCallback onForgotPassword;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: switchController,
      builder: (context, child) {
        return Transform.scale(
          scale: switchScaleAnimation.value,
          child: SlideTransition(
            position: switchSlideAnimation,
            child: Opacity(opacity: switchFadeAnimation.value.clamp(0.0, 1.0), child: child),
          ),
        );
      },
      child: Container(
        width: 380,
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: AppTheme.cardDark,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppTheme.borderDark),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.3), blurRadius: 40, offset: const Offset(0, 20)),
          ],
        ),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(animation),
                      child: child,
                    ),
                  );
                },
                child: Column(
                  key: ValueKey(state.isSignUp),
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color:
                            state.isSignUp
                                ? AppTheme.successAccent.withValues(alpha: 0.1)
                                : AppTheme.primaryAccent.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        state.isSignUp ? Icons.person_add : Icons.login,
                        size: 28,
                        color: state.isSignUp ? AppTheme.successAccent : AppTheme.primaryAccent,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      state.isSignUp ? 'Create Account' : 'Welcome Back',
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      state.isSignUp ? 'Sign up to get started' : 'Sign in to continue',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.textMuted),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email', prefixIcon: Icon(Icons.email_outlined)),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(state.obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                    onPressed: onToggleObscurePassword,
                  ),
                ),
                obscureText: state.obscurePassword,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => onSubmit(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              if (!state.isSignUp) ...[
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: onForgotPassword,
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text('Forgot Password?', style: TextStyle(color: AppTheme.primaryAccent, fontSize: 13)),
                  ),
                ),
              ],
              const SizedBox(height: 16),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                child: ElevatedButton(
                  onPressed: state.isSubmitting ? null : onSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: state.isSignUp ? AppTheme.successAccent : AppTheme.primaryAccent,
                  ),
                  child:
                      state.isSubmitting
                          ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2, color: AppTheme.primaryDark),
                          )
                          : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(state.isSignUp ? Icons.person_add : Icons.login, size: 18),
                              const SizedBox(width: 8),
                              Text(state.isSignUp ? 'Create Account' : 'Sign In'),
                            ],
                          ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(child: Container(height: 1, color: AppTheme.borderDark)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text('or', style: TextStyle(color: AppTheme.textMuted, fontSize: 12)),
                  ),
                  Expanded(child: Container(height: 1, color: AppTheme.borderDark)),
                ],
              ),
              const SizedBox(height: 20),
              OutlinedButton(
                onPressed: onToggleMode,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  side: BorderSide(
                    color:
                        state.isSignUp
                            ? AppTheme.primaryAccent.withValues(alpha: 0.5)
                            : AppTheme.successAccent.withValues(alpha: 0.5),
                  ),
                ),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: Row(
                    key: ValueKey(state.isSignUp),
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        state.isSignUp ? Icons.login : Icons.person_add,
                        size: 16,
                        color: state.isSignUp ? AppTheme.primaryAccent : AppTheme.successAccent,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        state.isSignUp ? 'Already have an account? Sign In' : "Don't have an account? Sign Up",
                        style: TextStyle(color: state.isSignUp ? AppTheme.primaryAccent : AppTheme.successAccent),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
