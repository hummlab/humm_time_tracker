import 'package:flutter/material.dart';
import 'package:time_tracker/models/org/team_member.dart';
import 'package:time_tracker/theme/app_theme.dart';

class TeamMembersDropdown extends StatefulWidget {
  const TeamMembersDropdown({super.key, required this.teamMembers, required this.selectedIds, required this.onChanged});

  final List<TeamMember> teamMembers;
  final List<String> selectedIds;
  final ValueChanged<List<String>> onChanged;

  @override
  State<TeamMembersDropdown> createState() => _TeamMembersDropdownState();
}

class _TeamMembersDropdownState extends State<TeamMembersDropdown> {
  final _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;

  void _toggleDropdown() {
    if (_isOpen) {
      _closeDropdown();
    } else {
      _openDropdown();
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
                width: size.width,
                child: CompositedTransformFollower(
                  link: _layerLink,
                  showWhenUnlinked: false,
                  offset: Offset(0, size.height + 4),
                  child: Material(
                    color: Colors.transparent,
                    child: _TeamMembersPicker(
                      teamMembers: widget.teamMembers,
                      selectedIds: widget.selectedIds,
                      onSelectionChanged: widget.onChanged,
                      onClose: _closeDropdown,
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
    if (mounted) {
      setState(() => _isOpen = false);
    }
  }

  @override
  void dispose() {
    _closeDropdown();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedMembers = widget.teamMembers.where((member) => widget.selectedIds.contains(member.id)).toList();

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
                Icons.people_outline,
                size: 18,
                color: selectedMembers.isNotEmpty ? AppTheme.primaryAccent : AppTheme.textMuted,
              ),
              const SizedBox(width: 8),
              Expanded(
                child:
                    selectedMembers.isEmpty
                        ? const Text('Select team members', style: TextStyle(color: AppTheme.textMuted))
                        : Wrap(
                          spacing: 4,
                          runSpacing: 4,
                          children: [
                            ...selectedMembers
                                .take(3)
                                .map(
                                  (member) => Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: AppTheme.primaryAccent.withValues(alpha: 0.2),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      member.name,
                                      style: const TextStyle(fontSize: 11, color: AppTheme.primaryAccent),
                                    ),
                                  ),
                                ),
                            if (selectedMembers.length > 3)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppTheme.textMuted.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  '+${selectedMembers.length - 3}',
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

class _TeamMembersPicker extends StatefulWidget {
  const _TeamMembersPicker({
    required this.teamMembers,
    required this.selectedIds,
    required this.onSelectionChanged,
    required this.onClose,
  });

  final List<TeamMember> teamMembers;
  final List<String> selectedIds;
  final ValueChanged<List<String>> onSelectionChanged;
  final VoidCallback onClose;

  @override
  State<_TeamMembersPicker> createState() => _TeamMembersPickerState();
}

class _TeamMembersPickerState extends State<_TeamMembersPicker> {
  final _searchController = TextEditingController();
  String _searchQuery = '';
  late List<String> _selectedIds;

  @override
  void initState() {
    super.initState();
    _selectedIds = List.from(widget.selectedIds);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _toggleMember(String id) {
    setState(() {
      if (_selectedIds.contains(id)) {
        _selectedIds.remove(id);
      } else {
        _selectedIds.add(id);
      }
    });
    widget.onSelectionChanged(_selectedIds);
  }

  @override
  Widget build(BuildContext context) {
    final filteredMembers =
        widget.teamMembers.where((member) {
          return member.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              member.email.toLowerCase().contains(_searchQuery.toLowerCase());
        }).toList();

    return Container(
      constraints: const BoxConstraints(maxHeight: 350),
      decoration: BoxDecoration(
        color: AppTheme.cardDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color.fromARGB(255, 2, 5, 8)),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.3), blurRadius: 20, offset: const Offset(0, 10))],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 8, 8),
            child: Row(
              children: [
                const Icon(Icons.people_outline, size: 16, color: AppTheme.primaryAccent),
                const SizedBox(width: 6),
                const Text('Team Members', style: TextStyle(fontWeight: FontWeight.w600)),
                if (_selectedIds.isNotEmpty) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryAccent.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '${_selectedIds.length} selected',
                      style: const TextStyle(color: AppTheme.primaryAccent, fontSize: 11, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
                const Spacer(),
                if (_selectedIds.isNotEmpty)
                  TextButton(
                    onPressed: () {
                      setState(() => _selectedIds.clear());
                      widget.onSelectionChanged(_selectedIds);
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      minimumSize: Size.zero,
                    ),
                    child: const Text('Clear', style: TextStyle(fontSize: 12)),
                  ),
                TextButton(
                  onPressed: widget.onClose,
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    minimumSize: Size.zero,
                  ),
                  child: const Text('Done', style: TextStyle(fontSize: 13)),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search team members...',
                prefixIcon: const Icon(Icons.search, size: 20),
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
              onChanged: (value) {
                setState(() => _searchQuery = value);
              },
            ),
          ),
          const SizedBox(height: 8),
          const Divider(height: 1),
          Flexible(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(vertical: 4),
              children:
                  filteredMembers.map((member) {
                    final isSelected = _selectedIds.contains(member.id);
                    return InkWell(
                      onTap: () => _toggleMember(member.id),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        color: isSelected ? AppTheme.primaryAccent.withValues(alpha: 0.1) : null,
                        child: Row(
                          children: [
                            Container(
                              width: 18,
                              height: 18,
                              decoration: BoxDecoration(
                                color: isSelected ? AppTheme.primaryAccent : Colors.transparent,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: AppTheme.primaryAccent, width: 2),
                              ),
                              child: isSelected ? const Icon(Icons.check, size: 12, color: Colors.white) : null,
                            ),
                            const SizedBox(width: 10),
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: AppTheme.primaryAccent.withValues(alpha: 0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  member.name.isNotEmpty ? member.name[0].toUpperCase() : '?',
                                  style: const TextStyle(
                                    color: AppTheme.primaryAccent,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    member.name,
                                    style: TextStyle(
                                      color: isSelected ? AppTheme.primaryAccent : AppTheme.textPrimary,
                                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                                    ),
                                  ),
                                  Text(member.email, style: TextStyle(fontSize: 11, color: AppTheme.textMuted)),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: _getRoleColor(member.role).withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                member.role.displayName,
                                style: TextStyle(
                                  fontSize: 9,
                                  color: _getRoleColor(member.role),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
            ),
          ),
        ],
      ),
    );
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
}
