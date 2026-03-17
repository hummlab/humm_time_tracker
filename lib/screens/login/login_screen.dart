import 'package:flutter/material.dart';
import 'package:time_tracker/app_dependencies.dart';
import 'package:time_tracker/cubit/cubit_builder.dart';
import 'package:time_tracker/screens/login/cubit/login_cubit.dart';
import 'package:time_tracker/screens/login/cubit/login_state.dart';
import 'package:time_tracker/config/app_config.dart';
import 'package:time_tracker/theme/app_theme.dart';
import 'package:time_tracker/widgets/app_toast.dart';
import 'package:time_tracker/screens/login/widgets/login_background.dart';
import 'package:time_tracker/screens/login/widgets/login_forgot_password_dialog.dart';
import 'package:time_tracker/screens/login/widgets/login_form.dart';
import 'package:time_tracker/screens/login/widgets/login_layouts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with TickerProviderStateMixin {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  late final LoginCubit _cubit;
  String? _lastErrorMessage;
  String? _lastSuccessMessage;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  late AnimationController _switchController;
  late Animation<double> _switchFadeAnimation;
  late Animation<Offset> _switchSlideAnimation;
  late Animation<double> _switchScaleAnimation;

  @override
  void initState() {
    super.initState();
    _cubit = LoginCubit(AppDependencies.instance.authDataProvider);
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _fadeAnimation = CurvedAnimation(parent: _animationController, curve: Curves.easeOut);
    _animationController.forward();

    // Animation for switching between sign in and sign up
    _switchController = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));
    _switchFadeAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _switchController, curve: const Interval(0.0, 0.5, curve: Curves.easeOut)));
    _switchSlideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, -0.1),
    ).animate(CurvedAnimation(parent: _switchController, curve: const Interval(0.0, 0.5, curve: Curves.easeOut)));
    _switchScaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(parent: _switchController, curve: const Interval(0.0, 0.5, curve: Curves.easeOut)));
  }

  @override
  void dispose() {
    _cubit.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _animationController.dispose();
    _switchController.dispose();
    super.dispose();
  }

  void _toggleMode() async {
    await _switchController.forward();
    _cubit.toggleMode();
    _switchController.reverse();
  }

  void _submit(LoginState state) async {
    if (!_formKey.currentState!.validate()) return;

    if (state.isSignUp) {
      await _cubit.signUp(_emailController.text.trim(), _passwordController.text);
      return;
    }

    await _cubit.signIn(_emailController.text.trim(), _passwordController.text);
  }

  Future<void> _showForgotPasswordDialog(LoginState state) async {
    await showLoginForgotPasswordDialog(
      context: context,
      state: state,
      initialEmail: _emailController.text,
      onSubmit: _cubit.sendPasswordReset,
    );
  }

  void _handleMessages(LoginState state) {
    if (state.errorMessage != null && state.errorMessage != _lastErrorMessage) {
      _lastErrorMessage = state.errorMessage;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        AppToast.show(context, state.errorMessage!, type: AppToastType.error);
      });
      _cubit.clearMessages();
    }

    if (state.successMessage != null && state.successMessage != _lastSuccessMessage) {
      _lastSuccessMessage = state.successMessage;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        AppToast.show(context, state.successMessage!, type: AppToastType.success);
      });
      _cubit.clearMessages();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CubitBuilder<LoginCubit, LoginState>(
      cubit: _cubit,
      builder: (context, state) {
        _handleMessages(state);
        final size = MediaQuery.of(context).size;
        final isDesktop = size.width > 800;
        final form = LoginForm(
          state: state,
          formKey: _formKey,
          emailController: _emailController,
          passwordController: _passwordController,
          switchController: _switchController,
          switchFadeAnimation: _switchFadeAnimation,
          switchSlideAnimation: _switchSlideAnimation,
          switchScaleAnimation: _switchScaleAnimation,
          onSubmit: () => _submit(state),
          onToggleMode: _toggleMode,
          onToggleObscurePassword: _cubit.toggleObscurePassword,
          onForgotPassword: () => _showForgotPasswordDialog(state),
        );

        return Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppTheme.primaryDark, Color(0xFF0D1B2A), Color(0xFF1B263B)],
              ),
            ),
            child: Stack(
              children: [
                // Background pattern
                Positioned.fill(child: CustomPaint(painter: LoginBackgroundPainter())),
                // Content
                Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: isDesktop ? LoginDesktopLayout(size: size, form: form) : LoginMobileLayout(form: form),
                    ),
                  ),
                ),
                // Version info
                Positioned(
                  bottom: 16,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Text(
                      AppConfig.fullVersion,
                      style: TextStyle(color: AppTheme.textMuted.withValues(alpha: 0.5), fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
