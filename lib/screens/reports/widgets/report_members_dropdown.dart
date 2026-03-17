import 'package:flutter/material.dart';
import 'package:time_tracker/models/org/team_member.dart';
import 'package:time_tracker/screens/reports/widgets/report_filter_item.dart';
import 'package:time_tracker/screens/reports/widgets/report_filters_pickers.dart';
import 'package:time_tracker/theme/app_theme.dart';

class ReportMembersDropdown extends StatefulWidget {
  const ReportMembersDropdown({
    super.key,
    required this.members,
    required this.selectedMemberIds,
    this.onChanged,
    this.isDisabled = false,
  });

  final List<TeamMember> members;
  final List<String> selectedMemberIds;
  final ValueChanged<List<String>>? onChanged;
  final bool isDisabled;

  @override
  State<ReportMembersDropdown> createState() => _ReportMembersDropdownState();
}

class _ReportMembersDropdownState extends State<ReportMembersDropdown> {
  final _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;

  void _toggleDropdown() {
    if (widget.isDisabled) return;

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
                      title: 'Members',
                      icon: Icons.people_outline,
                      items: widget.members.map((m) => FilterItem(m.id, m.name, null)).toList(),
                      selectedIds: widget.selectedMemberIds,
                      onSelectionChanged: widget.onChanged ?? (_) {},
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
    } else {
      _isOpen = false;
    }
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.cardDark,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      isScrollControlled: true,
      builder:
          (context) => MobileMultiSelectPicker(
            title: 'Members',
            icon: Icons.people_outline,
            items: widget.members.map((m) => FilterItem(m.id, m.name, null)).toList(),
            selectedIds: widget.selectedMemberIds,
            onSelectionChanged: widget.onChanged ?? (_) {},
          ),
    );
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedMembers = widget.members.where((m) => widget.selectedMemberIds.contains(m.id)).toList();
    final accentColor = widget.isDisabled ? AppTheme.textMuted : AppTheme.secondaryAccent;

    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: _toggleDropdown,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          decoration: BoxDecoration(
            color: widget.isDisabled ? AppTheme.surfaceDark.withValues(alpha: 0.5) : AppTheme.surfaceDark,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _isOpen ? AppTheme.primaryAccent : AppTheme.borderDark),
          ),
          child: Row(
            children: [
              Icon(
                Icons.people_outline,
                size: 18,
                color: selectedMembers.isNotEmpty ? accentColor : AppTheme.textMuted,
              ),
              const SizedBox(width: 8),
              Expanded(
                child:
                    selectedMembers.isEmpty
                        ? Text(
                          'All Members',
                          style: TextStyle(
                            color: widget.isDisabled ? AppTheme.textMuted.withValues(alpha: 0.5) : AppTheme.textMuted,
                          ),
                        )
                        : Wrap(
                          spacing: 4,
                          runSpacing: 4,
                          children: [
                            ...selectedMembers
                                .take(2)
                                .map(
                                  (member) => Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: accentColor.withValues(alpha: 0.2),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(member.name, style: TextStyle(fontSize: 11, color: accentColor)),
                                  ),
                                ),
                            if (selectedMembers.length > 2)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppTheme.textMuted.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  '+${selectedMembers.length - 2}',
                                  style: const TextStyle(fontSize: 11, color: AppTheme.textMuted),
                                ),
                              ),
                          ],
                        ),
              ),
              if (widget.isDisabled)
                const Icon(Icons.lock_outline, size: 16, color: AppTheme.textMuted)
              else
                Icon(_isOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down, color: AppTheme.textMuted),
            ],
          ),
        ),
      ),
    );
  }
}
