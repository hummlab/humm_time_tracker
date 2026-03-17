part of 'package:time_tracker/screens/time_tracking/time_tracking_screen.dart';

class TagsDropdown extends StatefulWidget {
  final List<String> selectedTagIds;
  final List<Tag> tags;
  final Function(List<String>) onChanged;

  const TagsDropdown({super.key, required this.selectedTagIds, required this.tags, required this.onChanged});

  @override
  State<TagsDropdown> createState() => _TagsDropdownState();
}

class _TagsDropdownState extends State<TagsDropdown> {
  final _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;
  bool _isDisposing = false;

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
                    child: _DesktopTagsPicker(
                      tags: widget.tags,
                      selectedTagIds: widget.selectedTagIds,
                      onSelectionChanged: (ids) {
                        widget.onChanged(ids);
                      },
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
    if (!_isDisposing && mounted) {
      setState(() => _isOpen = false);
    }
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.cardDark,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder:
          (context) => _MobileTagsPicker(
            tags: widget.tags,
            selectedTagIds: widget.selectedTagIds,
            onSelectionChanged: widget.onChanged,
          ),
    );
  }

  @override
  void dispose() {
    _isDisposing = true;
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
              Expanded(
                child:
                    selectedTags.isEmpty
                        ? const Text('Select tags', style: TextStyle(color: AppTheme.textMuted))
                        : Wrap(
                          spacing: 4,
                          runSpacing: 4,
                          children:
                              selectedTags.take(2).map((tag) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: AppTheme.colorFromHex(tag.color).withValues(alpha: 0.2),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      tag.name,
                                      style: TextStyle(fontSize: 11, color: AppTheme.colorFromHex(tag.color)),
                                    ),
                                  );
                                }).toList()
                                ..addAll(
                                  selectedTags.length > 2
                                      ? [
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
                                      ]
                                      : [],
                                ),
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

// Desktop Tags Picker
class _DesktopTagsPicker extends StatefulWidget {
  final List<Tag> tags;
  final List<String> selectedTagIds;
  final Function(List<String>) onSelectionChanged;
  final VoidCallback onClose;

  const _DesktopTagsPicker({
    required this.tags,
    required this.selectedTagIds,
    required this.onSelectionChanged,
    required this.onClose,
  });

  @override
  State<_DesktopTagsPicker> createState() => _DesktopTagsPickerState();
}

class _DesktopTagsPickerState extends State<_DesktopTagsPicker> {
  final _searchController = TextEditingController();
  String _searchQuery = '';
  late List<String> _selectedIds;

  @override
  void initState() {
    super.initState();
    _selectedIds = List.from(widget.selectedTagIds);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _toggleTag(String id) {
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
    final filteredTags =
        widget.tags.where((t) {
          return t.name.toLowerCase().contains(_searchQuery.toLowerCase());
        }).toList();

    return Container(
      constraints: const BoxConstraints(maxHeight: 350),
      decoration: BoxDecoration(
        color: AppTheme.cardDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.borderDark),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.3), blurRadius: 20, offset: const Offset(0, 10))],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 8, 8),
            child: Row(
              children: [
                if (_selectedIds.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryAccent.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '${_selectedIds.length} selected',
                      style: const TextStyle(color: AppTheme.primaryAccent, fontSize: 11, fontWeight: FontWeight.w600),
                    ),
                  ),
                const Spacer(),
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
                hintText: 'Search tags...',
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
                  filteredTags.map((tag) {
                    final isSelected = _selectedIds.contains(tag.id);
                    return InkWell(
                      onTap: () => _toggleTag(tag.id),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        color: isSelected ? AppTheme.colorFromHex(tag.color).withValues(alpha: 0.1) : null,
                        child: Row(
                          children: [
                            Container(
                              width: 18,
                              height: 18,
                              decoration: BoxDecoration(
                                color: isSelected ? AppTheme.colorFromHex(tag.color) : Colors.transparent,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: AppTheme.colorFromHex(tag.color), width: 2),
                              ),
                              child: isSelected ? const Icon(Icons.check, size: 12, color: Colors.white) : null,
                            ),
                            const SizedBox(width: 10),
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: AppTheme.colorFromHex(tag.color),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                tag.name,
                                style: TextStyle(
                                  color: isSelected ? AppTheme.colorFromHex(tag.color) : AppTheme.textPrimary,
                                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
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

// Mobile Tags Picker (Bottom Sheet)
class _MobileTagsPicker extends StatefulWidget {
  final List<Tag> tags;
  final List<String> selectedTagIds;
  final Function(List<String>) onSelectionChanged;

  const _MobileTagsPicker({required this.tags, required this.selectedTagIds, required this.onSelectionChanged});

  @override
  State<_MobileTagsPicker> createState() => _MobileTagsPickerState();
}

class _MobileTagsPickerState extends State<_MobileTagsPicker> {
  final _searchController = TextEditingController();
  String _searchQuery = '';
  late List<String> _selectedIds;

  @override
  void initState() {
    super.initState();
    _selectedIds = List.from(widget.selectedTagIds);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _toggleTag(String id) {
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
    final filteredTags =
        widget.tags.where((t) {
          return t.name.toLowerCase().contains(_searchQuery.toLowerCase());
        }).toList();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Text('Select Tags', style: Theme.of(context).textTheme.titleMedium),
              if (_selectedIds.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Container(
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
                ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  widget.onSelectionChanged(_selectedIds);
                  Navigator.pop(context);
                },
                child: const Text('Done'),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              hintText: 'Search tags...',
              prefixIcon: Icon(Icons.search),
              isDense: true,
            ),
            onChanged: (value) {
              setState(() => _searchQuery = value);
            },
          ),
        ),
        const SizedBox(height: 8),
        Flexible(
          child: ListView(
            shrinkWrap: true,
            children:
                filteredTags.map((tag) {
                  final isSelected = _selectedIds.contains(tag.id);
                  return CheckboxListTile(
                    value: isSelected,
                    onChanged: (_) => _toggleTag(tag.id),
                    secondary: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(color: AppTheme.colorFromHex(tag.color), shape: BoxShape.circle),
                    ),
                    title: Text(tag.name),
                    activeColor: AppTheme.primaryAccent,
                    checkColor: AppTheme.primaryDark,
                  );
                }).toList(),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

// Active Timer Widget
