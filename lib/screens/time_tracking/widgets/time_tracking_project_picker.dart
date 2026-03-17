part of 'package:time_tracker/screens/time_tracking/time_tracking_screen.dart';

class ProjectDropdown extends StatefulWidget {
  final String? selectedProjectId;
  final List<Project> projects;
  final Function(String?) onChanged;

  const ProjectDropdown({super.key, this.selectedProjectId, required this.projects, required this.onChanged});

  @override
  State<ProjectDropdown> createState() => _ProjectDropdownState();
}

class _ProjectDropdownState extends State<ProjectDropdown> {
  final _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;
  final bool _isDisposing = false;

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
                    child: _DesktopProjectPicker(
                      projects: widget.projects,
                      selectedProjectId: widget.selectedProjectId,
                      onSelected: (id) {
                        widget.onChanged(id);
                        _closeDropdown();
                      },
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
          (context) => _MobileProjectPicker(
            projects: widget.projects,
            selectedProjectId: widget.selectedProjectId,
            onSelected: (id) {
              widget.onChanged(id);
              Navigator.pop(context);
            },
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
    final selectedProject =
        widget.selectedProjectId != null
            ? widget.projects.where((p) => p.id == widget.selectedProjectId).firstOrNull
            : null;

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
              if (selectedProject != null) ...[
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: AppTheme.colorFromHex(selectedProject.color),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
              ],
              Expanded(
                child: Text(
                  selectedProject?.name ?? 'Select project',
                  style: TextStyle(color: selectedProject != null ? AppTheme.textPrimary : AppTheme.textMuted),
                  overflow: TextOverflow.ellipsis,
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

// Desktop Project Picker
class _DesktopProjectPicker extends StatefulWidget {
  final List<Project> projects;
  final String? selectedProjectId;
  final Function(String?) onSelected;

  const _DesktopProjectPicker({required this.projects, this.selectedProjectId, required this.onSelected});

  @override
  State<_DesktopProjectPicker> createState() => _DesktopProjectPickerState();
}

class _DesktopProjectPickerState extends State<_DesktopProjectPicker> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredProjects =
        widget.projects.where((p) {
          return p.name.toLowerCase().contains(_searchQuery.toLowerCase());
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
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search projects...',
                prefixIcon: const Icon(Icons.search, size: 20),
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
              onChanged: (value) {
                setState(() => _searchQuery = value);
              },
            ),
          ),
          const Divider(height: 1),
          Flexible(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(vertical: 4),
              children: [
                _buildProjectItem(null, 'No project', null),
                ...filteredProjects.map((project) => _buildProjectItem(project.id, project.name, project.color)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectItem(String? id, String name, String? color) {
    final isSelected = widget.selectedProjectId == id;
    return InkWell(
      onTap: () => widget.onSelected(id),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        color: isSelected ? AppTheme.primaryAccent.withValues(alpha: 0.1) : null,
        child: Row(
          children: [
            if (color != null) ...[
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(color: AppTheme.colorFromHex(color), shape: BoxShape.circle),
              ),
              const SizedBox(width: 10),
            ] else ...[
              const Icon(Icons.remove_circle_outline, size: 12, color: AppTheme.textMuted),
              const SizedBox(width: 10),
            ],
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                  color: isSelected ? AppTheme.primaryAccent : AppTheme.textPrimary,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ),
            if (isSelected) const Icon(Icons.check, size: 18, color: AppTheme.primaryAccent),
          ],
        ),
      ),
    );
  }
}

// Mobile Project Picker (Bottom Sheet)
class _MobileProjectPicker extends StatefulWidget {
  final List<Project> projects;
  final String? selectedProjectId;
  final Function(String?) onSelected;

  const _MobileProjectPicker({required this.projects, this.selectedProjectId, required this.onSelected});

  @override
  State<_MobileProjectPicker> createState() => _MobileProjectPickerState();
}

class _MobileProjectPickerState extends State<_MobileProjectPicker> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredProjects =
        widget.projects.where((p) {
          return p.name.toLowerCase().contains(_searchQuery.toLowerCase());
        }).toList();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Text('Select Project', style: Theme.of(context).textTheme.titleMedium),
              const Spacer(),
              IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              hintText: 'Search projects...',
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
            children: [
              ListTile(
                leading: const Icon(Icons.remove_circle_outline),
                title: const Text('No project'),
                trailing:
                    widget.selectedProjectId == null ? const Icon(Icons.check, color: AppTheme.primaryAccent) : null,
                onTap: () => widget.onSelected(null),
              ),
              ...filteredProjects.map(
                (project) => ListTile(
                  leading: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(color: AppTheme.colorFromHex(project.color), shape: BoxShape.circle),
                  ),
                  title: Text(project.name),
                  trailing:
                      widget.selectedProjectId == project.id
                          ? const Icon(Icons.check, color: AppTheme.primaryAccent)
                          : null,
                  onTap: () => widget.onSelected(project.id),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

// Tags Dropdown with Multi-select and Search
