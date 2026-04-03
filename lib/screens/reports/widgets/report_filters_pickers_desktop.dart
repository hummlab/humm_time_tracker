import 'package:flutter/material.dart';
import 'package:time_tracker/screens/reports/widgets/report_filter_item.dart';
import 'package:time_tracker/theme/app_theme.dart';

class DesktopMultiSelectPicker extends StatefulWidget {
  const DesktopMultiSelectPicker({
    super.key,
    required this.title,
    required this.icon,
    required this.items,
    required this.selectedIds,
    required this.onSelectionChanged,
    required this.onClose,
    this.compactItems = false,
  });

  final String title;
  final IconData icon;
  final List<FilterItem> items;
  final List<String> selectedIds;
  final ValueChanged<List<String>> onSelectionChanged;
  final VoidCallback onClose;
  final bool compactItems;

  @override
  State<DesktopMultiSelectPicker> createState() =>
      _DesktopMultiSelectPickerState();
}

class _DesktopMultiSelectPickerState extends State<DesktopMultiSelectPicker> {
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

  void _toggleItem(String id) {
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
    final filteredItems =
        widget.items.where((item) {
          return item.name.toLowerCase().contains(_searchQuery.toLowerCase());
        }).toList();

    return Container(
      constraints: const BoxConstraints(maxHeight: 400),
      decoration: BoxDecoration(
        color: AppTheme.cardDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.borderDark),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 8, 8),
            child: Row(
              children: [
                Icon(widget.icon, size: 16, color: AppTheme.primaryAccent),
                const SizedBox(width: 6),
                Text(
                  widget.title,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                if (_selectedIds.isNotEmpty) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryAccent.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '${_selectedIds.length} selected',
                      style: const TextStyle(
                        color: AppTheme.primaryAccent,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      minimumSize: Size.zero,
                    ),
                    child: const Text('Clear', style: TextStyle(fontSize: 12)),
                  ),
                TextButton(
                  onPressed: widget.onClose,
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
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
                hintText: 'Search ${widget.title.toLowerCase()}...',
                prefixIcon: const Icon(Icons.search, size: 20),
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
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
                  filteredItems.map((item) {
                    final isSelected = _selectedIds.contains(item.id);
                    final itemColor =
                        item.color != null
                            ? AppTheme.colorFromHex(item.color!)
                            : AppTheme.primaryAccent;

                    return InkWell(
                      onTap: () => _toggleItem(item.id),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 7,
                        ),
                        color:
                            isSelected
                                ? itemColor.withValues(alpha: 0.1)
                                : null,
                        child: Row(
                          children: [
                            Container(
                              width: widget.compactItems ? 16 : 18,
                              height: widget.compactItems ? 16 : 18,
                              decoration: BoxDecoration(
                                color:
                                    isSelected ? itemColor : Colors.transparent,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: itemColor, width: 2),
                              ),
                              child:
                                  isSelected
                                      ? const Icon(
                                        Icons.check,
                                        size: 10,
                                        color: Colors.white,
                                      )
                                      : null,
                            ),
                            SizedBox(width: widget.compactItems ? 8 : 10),
                            if (item.color != null) ...[
                              Container(
                                width: widget.compactItems ? 8 : 10,
                                height: widget.compactItems ? 8 : 10,
                                decoration: BoxDecoration(
                                  color: AppTheme.colorFromHex(item.color!),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 8),
                            ],
                            Expanded(
                              child: Text(
                                item.name,
                                style: TextStyle(
                                  fontSize: widget.compactItems ? 13 : 14,
                                  color:
                                      isSelected
                                          ? itemColor
                                          : AppTheme.textPrimary,
                                  fontWeight:
                                      isSelected
                                          ? FontWeight.w600
                                          : FontWeight.w400,
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
}
