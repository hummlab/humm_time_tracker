import 'package:flutter/material.dart';
import 'package:time_tracker/models/integrations/clickup_task.dart';
import 'package:time_tracker/models/projects/project.dart';
import 'package:time_tracker/theme/app_theme.dart';

class ClickUpSpacesSection extends StatelessWidget {
  const ClickUpSpacesSection({
    super.key,
    required this.spaces,
    required this.foldersBySpace,
    required this.folderlessListsBySpace,
    required this.expandedSpaces,
    required this.expandedFolders,
    required this.selectedListIds,
    required this.listProjectAssignments,
    required this.projects,
    required this.onToggleSpace,
    required this.onToggleFolder,
    required this.onToggleList,
    required this.onAssignProject,
  });

  final List<ClickUpSpace> spaces;
  final Map<String, List<ClickUpFolder>> foldersBySpace;
  final Map<String, List<ClickUpList>> folderlessListsBySpace;
  final Set<String> expandedSpaces;
  final Set<String> expandedFolders;
  final List<String> selectedListIds;
  final Map<String, String> listProjectAssignments;
  final List<Project> projects;
  final Future<void> Function(String) onToggleSpace;
  final ValueChanged<String> onToggleFolder;
  final ValueChanged<String> onToggleList;
  final Future<void> Function(String listId, String? projectId) onAssignProject;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.cardDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderDark),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppTheme.successAccent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.folder_special_outlined, color: AppTheme.successAccent, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Spaces & Lists', style: Theme.of(context).textTheme.titleMedium),
                    Text('Select lists to sync tasks from', style: TextStyle(fontSize: 12, color: AppTheme.textMuted)),
                  ],
                ),
              ),
              if (selectedListIds.isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryAccent.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${selectedListIds.length} selected',
                    style: const TextStyle(color: AppTheme.primaryAccent, fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          if (spaces.isEmpty)
            const Center(child: Padding(padding: EdgeInsets.all(20), child: CircularProgressIndicator()))
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: spaces.length,
              itemBuilder: (context, index) {
                return _SpaceItem(
                  space: spaces[index],
                  isExpanded: expandedSpaces.contains(spaces[index].id),
                  folders: foldersBySpace[spaces[index].id] ?? const [],
                  folderlessLists: folderlessListsBySpace[spaces[index].id] ?? const [],
                  expandedFolders: expandedFolders,
                  selectedListIds: selectedListIds,
                  listProjectAssignments: listProjectAssignments,
                  projects: projects,
                  onToggleSpace: onToggleSpace,
                  onToggleFolder: onToggleFolder,
                  onToggleList: onToggleList,
                  onAssignProject: onAssignProject,
                );
              },
            ),
        ],
      ),
    );
  }
}

class _SpaceItem extends StatelessWidget {
  const _SpaceItem({
    required this.space,
    required this.isExpanded,
    required this.folders,
    required this.folderlessLists,
    required this.expandedFolders,
    required this.selectedListIds,
    required this.listProjectAssignments,
    required this.projects,
    required this.onToggleSpace,
    required this.onToggleFolder,
    required this.onToggleList,
    required this.onAssignProject,
  });

  final ClickUpSpace space;
  final bool isExpanded;
  final List<ClickUpFolder> folders;
  final List<ClickUpList> folderlessLists;
  final Set<String> expandedFolders;
  final List<String> selectedListIds;
  final Map<String, String> listProjectAssignments;
  final List<Project> projects;
  final Future<void> Function(String) onToggleSpace;
  final ValueChanged<String> onToggleFolder;
  final ValueChanged<String> onToggleList;
  final Future<void> Function(String listId, String? projectId) onAssignProject;

  @override
  Widget build(BuildContext context) {
    final spaceColor = space.color != null ? AppTheme.colorFromHex(space.color!) : Colors.grey;

    return Column(
      children: [
        InkWell(
          onTap: () async => onToggleSpace(space.id),
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                Container(width: 8, height: 8, decoration: BoxDecoration(color: spaceColor, shape: BoxShape.circle)),
                const SizedBox(width: 12),
                Expanded(child: Text(space.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14))),
                if (space.private)
                  const Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Icon(Icons.lock_outline, size: 14, color: AppTheme.textMuted),
                  ),
                Icon(isExpanded ? Icons.expand_less : Icons.expand_more, color: AppTheme.textMuted),
              ],
            ),
          ),
        ),
        if (isExpanded) ...[
          ...folderlessLists.map(
            (list) => _ListItem(
              list: list,
              level: 1,
              selectedListIds: selectedListIds,
              listProjectAssignments: listProjectAssignments,
              projects: projects,
              onToggleList: onToggleList,
              onAssignProject: onAssignProject,
            ),
          ),
          ...folders.map(
            (folder) => _FolderItem(
              folder: folder,
              isExpanded: expandedFolders.contains(folder.id),
              selectedListIds: selectedListIds,
              listProjectAssignments: listProjectAssignments,
              projects: projects,
              onToggleFolder: onToggleFolder,
              onToggleList: onToggleList,
              onAssignProject: onAssignProject,
            ),
          ),
        ],
        const Divider(height: 1),
      ],
    );
  }
}

class _FolderItem extends StatelessWidget {
  const _FolderItem({
    required this.folder,
    required this.isExpanded,
    required this.selectedListIds,
    required this.listProjectAssignments,
    required this.projects,
    required this.onToggleFolder,
    required this.onToggleList,
    required this.onAssignProject,
  });

  final ClickUpFolder folder;
  final bool isExpanded;
  final List<String> selectedListIds;
  final Map<String, String> listProjectAssignments;
  final List<Project> projects;
  final ValueChanged<String> onToggleFolder;
  final ValueChanged<String> onToggleList;
  final Future<void> Function(String listId, String? projectId) onAssignProject;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () => onToggleFolder(folder.id),
          child: Container(
            padding: const EdgeInsets.only(left: 32, right: 12, top: 8, bottom: 8),
            child: Row(
              children: [
                Icon(isExpanded ? Icons.folder_open : Icons.folder, size: 16, color: AppTheme.textMuted),
                const SizedBox(width: 8),
                Expanded(child: Text(folder.name, style: const TextStyle(fontSize: 13, color: AppTheme.textSecondary))),
                Text('${folder.lists.length}', style: const TextStyle(fontSize: 11, color: AppTheme.textMuted)),
                const SizedBox(width: 8),
                Icon(isExpanded ? Icons.expand_less : Icons.expand_more, size: 18, color: AppTheme.textMuted),
              ],
            ),
          ),
        ),
        if (isExpanded)
          ...folder.lists.map(
            (list) => _ListItem(
              list: list,
              level: 2,
              selectedListIds: selectedListIds,
              listProjectAssignments: listProjectAssignments,
              projects: projects,
              onToggleList: onToggleList,
              onAssignProject: onAssignProject,
            ),
          ),
      ],
    );
  }
}

class _ListItem extends StatelessWidget {
  const _ListItem({
    required this.list,
    required this.level,
    required this.selectedListIds,
    required this.listProjectAssignments,
    required this.projects,
    required this.onToggleList,
    required this.onAssignProject,
  });

  final ClickUpList list;
  final int level;
  final List<String> selectedListIds;
  final Map<String, String> listProjectAssignments;
  final List<Project> projects;
  final ValueChanged<String> onToggleList;
  final Future<void> Function(String listId, String? projectId) onAssignProject;

  @override
  Widget build(BuildContext context) {
    final isSelected = selectedListIds.contains(list.id);
    final leftPadding = 32.0 + (level * 20);
    final assignedProjectId = listProjectAssignments[list.id];
    final selectedProject = assignedProjectId != null ? _findProject(projects, assignedProjectId) : null;

    return Container(
      padding: EdgeInsets.only(left: leftPadding, right: 12, top: 8, bottom: 8),
      color: isSelected ? AppTheme.primaryAccent.withValues(alpha: 0.1) : null,
      child: Row(
        children: [
          GestureDetector(
            onTap: () => onToggleList(list.id),
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: isSelected ? AppTheme.primaryAccent : Colors.transparent,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: isSelected ? AppTheme.primaryAccent : AppTheme.borderDark, width: 2),
              ),
              child: isSelected ? const Icon(Icons.check, size: 14, color: Colors.white) : null,
            ),
          ),
          const SizedBox(width: 10),
          Icon(Icons.list_alt, size: 14, color: isSelected ? AppTheme.primaryAccent : AppTheme.textMuted),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              list.name,
              style: TextStyle(
                fontSize: 13,
                color: isSelected ? AppTheme.primaryAccent : AppTheme.textSecondary,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ),
          if (isSelected) ...[
            const SizedBox(width: 8),
            _ProjectDropdown(
              listId: list.id,
              selectedProject: selectedProject,
              projects: projects,
              onAssignProject: onAssignProject,
            ),
          ],
        ],
      ),
    );
  }

  Project? _findProject(List<Project> projects, String id) {
    for (final project in projects) {
      if (project.id == id) return project;
    }
    return null;
  }
}

class _ProjectDropdown extends StatelessWidget {
  const _ProjectDropdown({
    required this.listId,
    required this.selectedProject,
    required this.projects,
    required this.onAssignProject,
  });

  final String listId;
  final Project? selectedProject;
  final List<Project> projects;
  final Future<void> Function(String listId, String? projectId) onAssignProject;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color:
            selectedProject != null
                ? AppTheme.colorFromHex(selectedProject!.color).withValues(alpha: 0.15)
                : AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color:
              selectedProject != null
                  ? AppTheme.colorFromHex(selectedProject!.color).withValues(alpha: 0.5)
                  : AppTheme.borderDark,
        ),
      ),
      child: PopupMenuButton<String?>(
        initialValue: selectedProject?.id,
        tooltip: 'Assign project',
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(minWidth: 150),
        offset: const Offset(0, 30),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (selectedProject != null) ...[
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(color: AppTheme.colorFromHex(selectedProject!.color), shape: BoxShape.circle),
              ),
              const SizedBox(width: 6),
            ],
            Text(
              selectedProject?.name ?? 'Assign project',
              style: TextStyle(
                fontSize: 11,
                color: selectedProject != null ? AppTheme.colorFromHex(selectedProject!.color) : AppTheme.textMuted,
                fontWeight: selectedProject != null ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.arrow_drop_down,
              size: 16,
              color: selectedProject != null ? AppTheme.colorFromHex(selectedProject!.color) : AppTheme.textMuted,
            ),
          ],
        ),
        onSelected: (projectId) => onAssignProject(listId, projectId),
        itemBuilder:
            (context) => [
              PopupMenuItem<String?>(
                value: null,
                child: Row(
                  children: [
                    const Icon(Icons.remove_circle_outline, size: 14, color: AppTheme.textMuted),
                    const SizedBox(width: 8),
                    const Text('No project', style: TextStyle(fontSize: 12)),
                  ],
                ),
              ),
              const PopupMenuDivider(),
              ...projects.map(
                (project) => PopupMenuItem<String?>(
                  value: project.id,
                  child: Row(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(color: AppTheme.colorFromHex(project.color), shape: BoxShape.circle),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          project.name,
                          style: const TextStyle(fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
      ),
    );
  }
}
