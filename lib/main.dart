import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker/app_dependencies.dart';
import 'package:time_tracker/cubit/cubit_builder.dart';
import 'package:time_tracker/screens/access_denied/access_denied_screen.dart';
import 'package:time_tracker/screens/client_dashboard/client_dashboard_screen.dart';
import 'package:time_tracker/screens/login/cubit/auth_cubit.dart';
import 'package:time_tracker/screens/login/cubit/auth_state.dart';
import 'package:time_tracker/screens/login/login_screen.dart';
import 'package:time_tracker/screens/main/main_screen.dart';
import 'package:time_tracker/screens/organization_setup/organization_setup_screen.dart';
import 'package:time_tracker/theme/app_theme.dart';

import 'config/app_config.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await AppConfig.init();
  AppDependencies.instance.init();
  runApp(const TimeTrackerApp());
}

class TimeTrackerApp extends StatelessWidget {
  const TimeTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = AppDependencies.instance.authCubit;

    return MaterialApp(
      title: 'Time Tracker',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: CubitBuilder<AuthCubit, AuthState>(
        cubit: authCubit,
        builder: (context, state) {
          if (state.isLoading) {
            return const _LoadingScreen();
          }

          if (state.isAuthenticated) {
            if (state.accessDenied) {
              return const AccessDeniedScreen();
            }
            if (state.needsOrganizationSetup) {
              return const OrganizationSetupScreen();
            }
            if (state.isClient) {
              return const ClientDashboardScreen();
            }
            return const MainScreen();
          }

          return const LoginScreen();
        },
      ),
    );
  }
}

class _LoadingScreen extends StatelessWidget {
  const _LoadingScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppTheme.primaryDark, Color(0xFF0D1B2A), Color(0xFF1B263B)],
          ),
        ),
        child: Center(
          child: Column(
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
              const SizedBox(height: 24),
              const CircularProgressIndicator(color: AppTheme.primaryAccent),
              const SizedBox(height: 16),
              Text(
                'Checking access...',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.textSecondary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
