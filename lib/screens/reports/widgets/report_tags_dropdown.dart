import 'package:flutter/material.dart';
import 'package:time_tracker/models/projects/tag.dart';
import 'package:time_tracker/screens/reports/widgets/report_filter_item.dart';
import 'package:time_tracker/screens/reports/widgets/report_filters_pickers.dart';
import 'package:time_tracker/theme/app_theme.dart';

class ReportTagsDropdown extends StatefulWidget {
  const ReportTagsDropdown({super.key, required this.tags, required this.selectedTagIds, required this.onChanged});

  final List<Tag> tags;
  final List<String> selectedTagIds;
  final ValueChanged<List<String>> onChanged;

  @override
  State<ReportTagsDropdown> createState() => _ReportTagsDropdownState();
}

class _ReportTagsDropdownState extends State<ReportTagsDropdown> {
  final _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;

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
                      title: 'Tags',
                      icon: Icons.tag,
                      items: widget.tags.map((t) => FilterItem(t.id, t.name, t.color)).toList(),
                      selectedIds: widget.selectedTagIds,
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
            title: 'Tags',
            icon: Icons.tag,
            items: widget.tags.map((t) => FilterItem(t.id, t.name, t.color)).toList(),
            selectedIds: widget.selectedTagIds,
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
    final selectedTags = widget.tags.where((t) => widget.selectedTagIds.contains(t.id)).toList();

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
              Icon(Icons.tag, size: 18, color: selectedTags.isNotEmpty ? AppTheme.primaryAccent : AppTheme.textMuted),
              const SizedBox(width: 8),
              Expanded(
                child:
                    selectedTags.isEmpty
                        ? const Text('All Tags', style: TextStyle(color: AppTheme.textMuted))
                        : Wrap(
                          spacing: 4,
                          runSpacing: 4,
                          children: [
                            ...selectedTags
                                .take(2)
                                .map(
                                  (tag) => Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: AppTheme.colorFromHex(tag.color).withValues(alpha: 0.2),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      tag.name,
                                      style: TextStyle(fontSize: 11, color: AppTheme.colorFromHex(tag.color)),
                                    ),
                                  ),
                                ),
                            if (selectedTags.length > 2)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppTheme.textMuted.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  '+${selectedTags.length - 2}',
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
