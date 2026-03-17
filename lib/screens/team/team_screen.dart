import 'package:flutter/material.dart';
import 'package:time_tracker/app_dependencies.dart';
import 'package:time_tracker/cubit/cubit_builder.dart';
import 'package:time_tracker/models/org/team_member.dart';
import 'package:time_tracker/screens/team/cubit/team_cubit.dart';
import 'package:time_tracker/screens/team/cubit/team_state.dart';
import 'package:time_tracker/screens/team/widgets/team_empty_state.dart';
import 'package:time_tracker/screens/team/widgets/team_member_dialog.dart';
import 'package:time_tracker/screens/team/widgets/team_members_grid.dart';
import 'package:time_tracker/theme/app_theme.dart';
import 'package:time_tracker/widgets/app_toast.dart';

class TeamScreen extends StatefulWidget {
  const TeamScreen({super.key});

  @override
  State<TeamScreen> createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  late final TeamCubit _cubit;
  String? _lastToastMessage;

  @override
  void initState() {
    super.initState();
    _cubit = TeamCubit(
      AppDependencies.instance.workspaceRepository,
      AppDependencies.instance.teamMembersRepository,
      AppDependencies.instance.authDataProvider,
    );
  }

  @override
  void dispose() {
    _cubit.dispose();
    super.dispose();
  }

  void _handleToast(TeamState state) {
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
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 800;

    return CubitBuilder<TeamCubit, TeamState>(
      cubit: _cubit,
      builder: (context, state) {
        _handleToast(state);

        return Scaffold(
          backgroundColor: Colors.transparent,
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => _showAddMemberDialog(context),
            icon: const Icon(Icons.person_add),
            label: const Text('Add Member'),
          ),
          body:
              state.cards.isEmpty
                  ? TeamEmptyState(onAddMember: () => _showAddMemberDialog(context))
                  : TeamMembersGrid(
                    cards: state.cards,
                    isDesktop: isDesktop,
                    onTap: (member) => _showEditMemberDialog(context, member),
                    onDelete: (member) => _confirmDelete(context, member),
                  ),
        );
      },
    );
  }

  void _showAddMemberDialog(BuildContext context) {
    _showMemberDialog(context, null);
  }

  void _showEditMemberDialog(BuildContext context, TeamMember member) {
    _showMemberDialog(context, member);
  }

  Future<void> _showMemberDialog(BuildContext context, TeamMember? member) async {
    await showDialog<void>(context: context, builder: (context) => TeamMemberDialog(cubit: _cubit, member: member));
  }

  void _confirmDelete(BuildContext context, TeamMember member) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Remove Team Member'),
          content: Text('Are you sure you want to remove "${member.name}" from the team?'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            ElevatedButton(
              onPressed: () {
                _cubit.deleteMember(member);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(backgroundColor: AppTheme.tertiaryAccent),
              child: const Text('Remove'),
            ),
          ],
        );
      },
    );
  }
}
