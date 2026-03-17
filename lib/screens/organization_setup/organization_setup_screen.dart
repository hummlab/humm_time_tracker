import 'package:flutter/material.dart';
import 'package:time_tracker/app_dependencies.dart';
import 'package:time_tracker/cubit/cubit_builder.dart';
import 'package:time_tracker/screens/organization_setup/cubit/organization_setup_cubit.dart';
import 'package:time_tracker/screens/organization_setup/cubit/organization_setup_state.dart';
import 'package:time_tracker/theme/app_theme.dart';
import 'package:time_tracker/widgets/app_toast.dart';

class OrganizationSetupScreen extends StatefulWidget {
  const OrganizationSetupScreen({super.key});

  @override
  State<OrganizationSetupScreen> createState() => _OrganizationSetupScreenState();
}

class _OrganizationSetupScreenState extends State<OrganizationSetupScreen> {
  final TextEditingController _organizationNameController = TextEditingController();
  late final OrganizationSetupCubit _cubit;
  String? _lastToastMessage;

  bool get _canClose => Navigator.of(context).canPop();

  void _closeIfPossible() {
    if (_canClose) {
      Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    super.initState();
    _cubit = OrganizationSetupCubit(
      AppDependencies.instance.authDataProvider,
      AppDependencies.instance.timeDataProvider,
    );
  }

  @override
  void dispose() {
    _organizationNameController.dispose();
    _cubit.dispose();
    super.dispose();
  }

  void _handleToast(OrganizationSetupState state) {
    final message = state.toastMessage;
    if (message == null || message == _lastToastMessage) return;

    _lastToastMessage = message;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AppToast.show(context, message, type: state.toastType ?? AppToastType.info);
    });
    _cubit.clearToast();
  }

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
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 560),
              child: CubitBuilder<OrganizationSetupCubit, OrganizationSetupState>(
                cubit: _cubit,
                builder: (context, state) {
                  _handleToast(state);
                  final organizations = state.organizations;
                  final invites = state.invites;
                  final isLoading = state.isLoadingOrganizations;
                  final isLoadingInvites = state.isLoadingInvites;

                  return Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppTheme.cardDark,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppTheme.borderDark),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text('Organization Setup', style: Theme.of(context).textTheme.headlineSmall),
                            ),
                            IconButton(
                              icon: const Icon(Icons.logout_outlined),
                              tooltip: 'Logout',
                              onPressed: state.isSigningOut ? null : _cubit.signOut,
                              color: AppTheme.textSecondary,
                            ),
                            if (_canClose)
                              IconButton(
                                icon: const Icon(Icons.close),
                                tooltip: 'Close',
                                onPressed: _closeIfPossible,
                                color: AppTheme.textSecondary,
                              ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          organizations.isEmpty && invites.isEmpty
                              ? 'You are not assigned to any organization yet. Create your first organization to start.'
                              : 'You can join one of your organizations or create a new one.',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.textSecondary),
                        ),
                        const SizedBox(height: 24),
                        if (isLoading || isLoadingInvites)
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Center(child: CircularProgressIndicator()),
                          )
                        else ...[
                          if (invites.isNotEmpty) ...[
                            Text('Invitations', style: Theme.of(context).textTheme.titleMedium),
                            const SizedBox(height: 12),
                            ...invites.map(
                              (invite) => Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                child: ListTile(
                                  tileColor: AppTheme.surfaceDark,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    side: const BorderSide(color: AppTheme.borderDark),
                                  ),
                                  title: Text(invite.organizationName),
                                  subtitle: Text('Role: ${invite.role.toString().split('.').last}'),
                                  trailing: ElevatedButton(
                                    onPressed: () async {
                                      final success = await _cubit.acceptInvite(invite);
                                      if (!mounted) return;
                                      if (success) {
                                        _closeIfPossible();
                                      }
                                    },
                                    child: const Text('Join'),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Divider(color: AppTheme.borderDark),
                            const SizedBox(height: 20),
                          ],
                          if (organizations.isNotEmpty) ...[
                            Text('Available organizations', style: Theme.of(context).textTheme.titleMedium),
                            const SizedBox(height: 12),
                            ...organizations.map(
                              (organization) => Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                child: ListTile(
                                  tileColor: AppTheme.surfaceDark,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    side: const BorderSide(color: AppTheme.borderDark),
                                  ),
                                  title: Text(organization.name),
                                  subtitle: Text('ID: ${organization.id}'),
                                  trailing: const Icon(Icons.arrow_forward_ios),
                                  onTap: () async {
                                    await _cubit.selectOrganization(organization.id);
                                    if (!mounted) return;
                                    _closeIfPossible();
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Divider(color: AppTheme.borderDark),
                            const SizedBox(height: 20),
                          ],
                          TextField(
                            controller: _organizationNameController,
                            decoration: const InputDecoration(
                              labelText: 'New organization name',
                              prefixIcon: Icon(Icons.business_outlined),
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed:
                                  state.isLoadingOrganizations
                                      ? null
                                      : () async {
                                        final success = await _cubit.createOrganization(
                                          _organizationNameController.text,
                                        );
                                        if (!mounted) return;
                                        if (success) {
                                          _closeIfPossible();
                                        }
                                      },
                              icon: const Icon(Icons.add_business),
                              label: const Text('Create Organization'),
                            ),
                          ),
                        ],
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
