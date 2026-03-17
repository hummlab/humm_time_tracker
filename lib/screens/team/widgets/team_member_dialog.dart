import 'package:flutter/material.dart';
import 'package:time_tracker/models/org/team_member.dart';
import 'package:time_tracker/screens/team/cubit/team_cubit.dart';
import 'package:time_tracker/theme/app_theme.dart';

class TeamMemberDialog extends StatefulWidget {
  const TeamMemberDialog({super.key, required this.cubit, this.member});

  final TeamCubit cubit;
  final TeamMember? member;

  @override
  State<TeamMemberDialog> createState() => _TeamMemberDialogState();
}

class _TeamMemberDialogState extends State<TeamMemberDialog> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late TeamMemberRole _selectedRole;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.member?.name ?? '');
    _emailController = TextEditingController(text: widget.member?.email ?? '');
    _selectedRole = widget.member?.role ?? TeamMemberRole.regular;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    setState(() => _isLoading = true);
    final saved = await widget.cubit.saveMember(
      existing: widget.member,
      name: _nameController.text,
      email: _emailController.text,
      role: _selectedRole,
    );
    if (!mounted) return;
    setState(() => _isLoading = false);
    if (!saved) return;
    Navigator.pop(context);
  }

  IconData _getRoleIcon(TeamMemberRole role) {
    switch (role) {
      case TeamMemberRole.admin:
        return Icons.admin_panel_settings;
      case TeamMemberRole.manager:
        return Icons.manage_accounts;
      case TeamMemberRole.regular:
        return Icons.person;
      case TeamMemberRole.client:
        return Icons.business;
    }
  }

  Color _getRoleColor(TeamMemberRole role) {
    switch (role) {
      case TeamMemberRole.admin:
        return AppTheme.tertiaryAccent;
      case TeamMemberRole.manager:
        return AppTheme.warningAccent;
      case TeamMemberRole.regular:
        return AppTheme.primaryAccent;
      case TeamMemberRole.client:
        return AppTheme.warningAccent;
    }
  }

  @override
  Widget build(BuildContext context) {
    final config = widget.cubit.dialogConfigFor(widget.member);

    return AlertDialog(
      title: Text(widget.member == null ? 'Add Team Member' : 'Edit Team Member'),
      content: SizedBox(
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name', prefixIcon: Icon(Icons.person_outline)),
              enabled: config.canEditName,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email', prefixIcon: Icon(Icons.email_outlined)),
              keyboardType: TextInputType.emailAddress,
              enabled: widget.member == null,
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: AppTheme.surfaceDark,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.borderDark),
              ),
              child:
                  config.canChangeRole
                      ? DropdownButtonHideUnderline(
                        child: DropdownButton<TeamMemberRole>(
                          value: _selectedRole,
                          isExpanded: true,
                          dropdownColor: AppTheme.cardDark,
                          items:
                              config.availableRoles.map((role) {
                                return DropdownMenuItem<TeamMemberRole>(
                                  value: role,
                                  child: Row(
                                    children: [
                                      Icon(_getRoleIcon(role), size: 18, color: _getRoleColor(role)),
                                      const SizedBox(width: 8),
                                      Text(role.displayName),
                                    ],
                                  ),
                                );
                              }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              setState(() {
                                _selectedRole = value;
                              });
                            }
                          },
                        ),
                      )
                      : Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Row(
                          children: [
                            Icon(
                              _getRoleIcon(widget.member!.role),
                              size: 18,
                              color: _getRoleColor(widget.member!.role),
                            ),
                            const SizedBox(width: 8),
                            Text(widget.member!.role.displayName),
                            const SizedBox(width: 8),
                            const Icon(Icons.lock, size: 16, color: AppTheme.textMuted),
                          ],
                        ),
                      ),
            ),
            if (widget.member == null) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.warningAccent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppTheme.warningAccent.withValues(alpha: 0.3)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, size: 18, color: AppTheme.warningAccent),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        'An invitation will be sent. The user can sign up with this email and join your organization.',
                        style: TextStyle(fontSize: 12, color: AppTheme.warningAccent),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: _isLoading ? null : () => Navigator.pop(context), child: const Text('Cancel')),
        ElevatedButton(
          onPressed: _isLoading ? null : _save,
          child:
              _isLoading
                  ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2, color: AppTheme.primaryDark),
                  )
                  : Text(widget.member == null ? 'Add' : 'Save'),
        ),
      ],
    );
  }
}
