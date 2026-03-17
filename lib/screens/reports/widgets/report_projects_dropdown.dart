import 'package:flutter/material.dart';
import 'package:time_tracker/models/projects/project.dart';
import 'package:time_tracker/screens/reports/widgets/report_filter_item.dart';
import 'package:time_tracker/screens/reports/widgets/report_filters_pickers.dart';
import 'package:time_tracker/theme/app_theme.dart';

class ReportProjectsDropdown extends StatefulWidget {
  const ReportProjectsDropdown({
    super.key,
    required this.projects,
    required this.selectedProjectIds,
    required this.onChanged,
  });

  final List<Project> projects;
  final List<String> selectedProjectIds;
  final ValueChanged<List<String>> onChanged;

  @override
  State<ReportProjectsDropdown> createState() => _ReportProjectsDropdownState();
}

class _ReportProjectsDropdownState extends State<ReportProjectsDropdown> {
  final _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;

  List<Project> get _sortedProjects {
    final projects = List<Project>.from(widget.projects);
    projects.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    return projects;
  }

  void _toggleDropdown() {
    final isDesktop = MediaQuery.of(context).size.width > 800;
    if (isDesktop) {
      if (_isOpen) {
        _closeDropdown();
      } else {
        _openDropdown();
      }
    } else {
      _showBottomSheet();
    }
  }

  void _openDropdown() {
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder:
          (context) => Stack(
            children: [
              Positioned.fill(
                child: GestureDetector(
                  onTap: _closeDropdown,
                  behavior: HitTestBehavior.opaque,
                  child: Container(color: Colors.transparent),
                ),
              ),
              Positioned(
                width: 300,
                child: CompositedTransformFollower(
                  link: _layerLink,
                  showWhenUnlinked: false,
                  offset: Offset(0, size.height + 4),
                  child: Material(
                    color: Colors.transparent,
                    child: DesktopMultiSelectPicker(
                      title: 'Projects',
                      icon: Icons.folder_outlined,
                      items: _sortedProjects.map((p) => FilterItem(p.id, p.name, p.color)).toList(),
                      selectedIds: widget.selectedProjectIds,
                      onSelectionChanged: widget.onChanged,
                      onClose: _closeDropdown,
                      compactItems: true,
                    ),
                  ),
                ),
              ),
            ],
          ),
    );

    overlay.insert(_overlayEntry!);
    setState(() => _isOpen = true);
  }

  void _closeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() => _isOpen = false);
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.cardDark,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      isScrollControlled: true,
      builder:
          (context) => MobileMultiSelectPicker(
            title: 'Projects',
            icon: Icons.folder_outlined,
            items: _sortedProjects.map((p) => FilterItem(p.id, p.name, p.color)).toList(),
            selectedIds: widget.selectedProjectIds,
            onSelectionChanged: widget.onChanged,
            compactItems: true,
          ),
    );
  }

  @override
  void dispose() {
    _closeDropdown();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedProjects = _sortedProjects.where((p) => widget.selectedProjectIds.contains(p.id)).toList();

    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: _toggleDropdown,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          decoration: BoxDecoration(
            color: AppTheme.surfaceDark,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _isOpen ? AppTheme.primaryAccent : AppTheme.borderDark),
          ),
          child: Row(
            children: [
              Icon(
                Icons.folder_outlined,
                size: 18,
                color: selectedProjects.isNotEmpty ? AppTheme.primaryAccent : AppTheme.textMuted,
              ),
              const SizedBox(width: 8),
              Expanded(
                child:
                    selectedProjects.isEmpty
                        ? const Text('All Projects', style: TextStyle(color: AppTheme.textMuted))
                        : Wrap(
                          spacing: 4,
                          runSpacing: 4,
                          children: [
                            ...selectedProjects
                                .take(2)
                                .map(
                                  (project) => Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: AppTheme.colorFromHex(project.color).withValues(alpha: 0.2),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      project.name,
                                      style: TextStyle(fontSize: 11, color: AppTheme.colorFromHex(project.color)),
                                    ),
                                  ),
                                ),
                            if (selectedProjects.length > 2)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppTheme.textMuted.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  '+${selectedProjects.length - 2}',
                                  style: const TextStyle(fontSize: 11, color: AppTheme.textMuted),
                                ),
                              ),
                          ],
                        ),
              ),
              Icon(_isOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down, color: AppTheme.textMuted),
            ],
          ),
        ),
      ),
    );
  }
}
