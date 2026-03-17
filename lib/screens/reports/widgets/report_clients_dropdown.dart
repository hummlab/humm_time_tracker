import 'package:flutter/material.dart';
import 'package:time_tracker/models/projects/client.dart';
import 'package:time_tracker/screens/reports/widgets/report_filter_item.dart';
import 'package:time_tracker/screens/reports/widgets/report_filters_pickers.dart';
import 'package:time_tracker/theme/app_theme.dart';

class ReportClientsDropdown extends StatefulWidget {
  const ReportClientsDropdown({
    super.key,
    required this.clients,
    required this.selectedClientIds,
    required this.onChanged,
  });

  final List<Client> clients;
  final List<String> selectedClientIds;
  final ValueChanged<List<String>> onChanged;

  @override
  State<ReportClientsDropdown> createState() => _ReportClientsDropdownState();
}

class _ReportClientsDropdownState extends State<ReportClientsDropdown> {
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
                      title: 'Clients',
                      icon: Icons.business,
                      items: widget.clients.map((c) => FilterItem(c.id, c.name, null)).toList(),
                      selectedIds: widget.selectedClientIds,
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
            title: 'Clients',
            icon: Icons.business,
            items: widget.clients.map((c) => FilterItem(c.id, c.name, null)).toList(),
            selectedIds: widget.selectedClientIds,
            onSelectionChanged: widget.onChanged,
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
    final selectedClients = widget.clients.where((c) => widget.selectedClientIds.contains(c.id)).toList();

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
                Icons.business,
                size: 18,
                color: selectedClients.isNotEmpty ? AppTheme.primaryAccent : AppTheme.textMuted,
              ),
              const SizedBox(width: 8),
              Expanded(
                child:
                    selectedClients.isEmpty
                        ? const Text('All Clients', style: TextStyle(color: AppTheme.textMuted))
                        : Wrap(
                          spacing: 4,
                          runSpacing: 4,
                          children: [
                            ...selectedClients
                                .take(2)
                                .map(
                                  (client) => Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: AppTheme.primaryAccent.withValues(alpha: 0.2),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      client.name,
                                      style: const TextStyle(fontSize: 11, color: AppTheme.primaryAccent),
                                    ),
                                  ),
                                ),
                            if (selectedClients.length > 2)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppTheme.textMuted.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  '+${selectedClients.length - 2}',
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
