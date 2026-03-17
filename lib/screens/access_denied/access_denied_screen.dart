import 'package:flutter/material.dart';
import 'package:time_tracker/app_dependencies.dart';
import 'package:time_tracker/cubit/cubit_builder.dart';
import 'package:time_tracker/screens/access_denied/cubit/access_denied_cubit.dart';
import 'package:time_tracker/screens/access_denied/cubit/access_denied_state.dart';
import 'package:time_tracker/screens/access_denied/widgets/access_denied_view.dart';

class AccessDeniedScreen extends StatefulWidget {
  const AccessDeniedScreen({super.key});

  @override
  State<AccessDeniedScreen> createState() => _AccessDeniedScreenState();
}

class _AccessDeniedScreenState extends State<AccessDeniedScreen> {
  late final AccessDeniedCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = AccessDeniedCubit(AppDependencies.instance.authDataProvider, AppDependencies.instance.timeDataProvider);
  }

  @override
  void dispose() {
    _cubit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CubitBuilder<AccessDeniedCubit, AccessDeniedState>(
        cubit: _cubit,
        builder: (context, state) {
          return AccessDeniedView(email: state.email, onSignOut: _cubit.signOut);
        },
      ),
    );
  }
}
