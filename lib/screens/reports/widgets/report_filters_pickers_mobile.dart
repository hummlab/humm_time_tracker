import 'package:flutter/material.dart';
import 'package:time_tracker/screens/reports/widgets/report_filter_item.dart';
import 'package:time_tracker/theme/app_theme.dart';

class MobileMultiSelectPicker extends StatefulWidget {
  const MobileMultiSelectPicker({
    super.key,
    required this.title,
    required this.icon,
    required this.items,
    required this.selectedIds,
    required this.onSelectionChanged,
    this.compactItems = false,
  });

  final String title;
  final IconData icon;
  final List<FilterItem> items;
  final List<String> selectedIds;
  final ValueChanged<List<String>> onSelectionChanged;
  final bool compactItems;

  @override
  State<MobileMultiSelectPicker> createState() => _MobileMultiSelectPickerState();
}

class _MobileMultiSelectPickerState extends State<MobileMultiSelectPicker> {
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
  }

  @override
  Widget build(BuildContext context) {
    final filteredItems =
        widget.items.where((item) {
          return item.name.toLowerCase().contains(_searchQuery.toLowerCase());
        }).toList();

    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Icon(widget.icon, size: 20, color: AppTheme.primaryAccent),
              const SizedBox(width: 8),
              Text(widget.title, style: Theme.of(context).textTheme.titleMedium),
              if (_selectedIds.isNotEmpty) ...[
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryAccent.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '${_selectedIds.length}',
                    style: const TextStyle(color: AppTheme.primaryAccent, fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
              const Spacer(),
              if (_selectedIds.isNotEmpty)
                TextButton(
                  onPressed: () {
                    setState(() => _selectedIds.clear());
                  },
                  child: const Text('Clear'),
                ),
              IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
            ],
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search ${widget.title.toLowerCase()}...',
              prefixIcon: const Icon(Icons.search),
            ),
            onChanged: (value) {
              setState(() => _searchQuery = value);
            },
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView(
              children:
                  filteredItems.map((item) {
                    final isSelected = _selectedIds.contains(item.id);
                    final itemColor = item.color != null ? AppTheme.colorFromHex(item.color!) : AppTheme.primaryAccent;

                    return CheckboxListTile(
                      value: isSelected,
                      onChanged: (_) => _toggleItem(item.id),
                      dense: widget.compactItems,
                      visualDensity: widget.compactItems ? const VisualDensity(horizontal: 0, vertical: -3) : null,
                      contentPadding: widget.compactItems ? const EdgeInsets.symmetric(horizontal: 4) : null,
                      secondary:
                          item.color != null
                              ? Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                  color: AppTheme.colorFromHex(item.color!),
                                  shape: BoxShape.circle,
                                ),
                              )
                              : Icon(widget.icon, size: widget.compactItems ? 18 : 20, color: AppTheme.textMuted),
                      title: Text(item.name, style: TextStyle(fontSize: widget.compactItems ? 13 : 15)),
                      activeColor: itemColor,
                      checkColor: Colors.white,
                    );
                  }).toList(),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                widget.onSelectionChanged(_selectedIds);
                Navigator.pop(context);
              },
              child: const Text('Apply'),
            ),
          ),
        ],
      ),
    );
  }
}
