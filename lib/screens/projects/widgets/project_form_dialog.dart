import 'package:flutter/material.dart';
import 'package:time_tracker/models/org/team_member.dart';
import 'package:time_tracker/models/projects/client.dart';
import 'package:time_tracker/models/projects/project.dart';
import 'package:time_tracker/screens/projects/cubit/projects_cubit.dart';
import 'package:time_tracker/screens/projects/widgets/team_members_dropdown.dart';
import 'package:time_tracker/theme/app_theme.dart';

class ProjectFormDialog extends StatefulWidget {
  const ProjectFormDialog({
    super.key,
    required this.cubit,
    required this.clients,
    required this.teamMembers,
    this.project,
  });

  final ProjectsCubit cubit;
  final List<Client> clients;
  final List<TeamMember> teamMembers;
  final Project? project;

  @override
  State<ProjectFormDialog> createState() => _ProjectFormDialogState();
}

class _ProjectFormDialogState extends State<ProjectFormDialog> {
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  String? _selectedClientId;
  List<String> _selectedTeamMemberIds = [];
  late String _selectedColor;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.project?.name ?? '');
    _descriptionController = TextEditingController(text: widget.project?.description ?? '');
    _selectedClientId = widget.project?.clientId;
    _selectedTeamMemberIds = List.from(widget.project?.teamMemberIds ?? []);
    _selectedColor = widget.project?.color ?? '#6366F1';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final saved = await widget.cubit.saveProject(
      existing: widget.project,
      name: _nameController.text,
      description: _descriptionController.text,
      clientId: _selectedClientId,
      teamMemberIds: _selectedTeamMemberIds,
      color: _selectedColor,
    );

    if (!saved) return;
    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.project == null ? 'New Project' : 'Edit Project'),
      content: SizedBox(
        width: 450,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Project Name', prefixIcon: Icon(Icons.folder_outlined)),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description (optional)',
                  prefixIcon: Icon(Icons.description_outlined),
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 20),
              Text('Color', style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppTheme.textSecondary)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children:
                    AppTheme.projectColors.map((color) {
                      final hexColor =
                          '#${(color.toARGB32() & 0xFFFFFF).toRadixString(16).padLeft(6, '0').toUpperCase()}';
                      final isSelected = _selectedColor == hexColor;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedColor = hexColor;
                          });
                        },
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                            border: isSelected ? Border.all(color: AppTheme.textPrimary, width: 3) : null,
                          ),
                          child: isSelected ? const Icon(Icons.check, size: 18, color: Colors.white) : null,
                        ),
                      );
                    }).toList(),
              ),
              const SizedBox(height: 20),
              Text('Client', style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppTheme.textSecondary)),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceDark,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppTheme.borderDark),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String?>(
                    value: _selectedClientId,
                    isExpanded: true,
                    hint: const Text('Select client'),
                    dropdownColor: AppTheme.cardDark,
                    items: [
                      const DropdownMenuItem<String?>(value: null, child: Text('No client')),
                      ...widget.clients.map((client) {
                        return DropdownMenuItem<String?>(value: client.id, child: Text(client.name));
                      }),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedClientId = value;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Team Members',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppTheme.textSecondary),
              ),
              const SizedBox(height: 8),
              TeamMembersDropdown(
                teamMembers: widget.teamMembers,
                selectedIds: _selectedTeamMemberIds,
                onChanged: (ids) {
                  setState(() {
                    _selectedTeamMemberIds = ids;
                  });
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        ElevatedButton(onPressed: _save, child: Text(widget.project == null ? 'Create' : 'Save')),
      ],
    );
  }
}
