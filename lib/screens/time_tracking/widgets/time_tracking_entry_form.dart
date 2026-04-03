part of 'package:time_tracker/screens/time_tracking/time_tracking_screen.dart';

class TimeEntryForm extends StatefulWidget {
  final TimeTrackingCubit cubit;
  final TimeEntry? editingEntry;
  final String? initialDescription;
  final VoidCallback? onCancelEdit;
  final VoidCallback? onSaved;

  const TimeEntryForm({
    super.key,
    required this.cubit,
    this.editingEntry,
    this.initialDescription,
    this.onCancelEdit,
    this.onSaved,
  });

  @override
  State<TimeEntryForm> createState() => TimeEntryFormState();
}

class TimeEntryFormState extends State<TimeEntryForm> {
  final _descriptionController = TextEditingController();
  final _descriptionFocusNode = FocusNode();
  final _startTimeController = TextEditingController();
  int? _selectedDuration;
  String? _selectedProjectId;
  List<String> _selectedTagIds = [];
  TimeOfDay? _selectedStartTime;

  // Inline validation errors
  String? _descriptionError;
  String? _durationError;

  // ClickUp task search
  List<ClickUpTask> _clickUpSuggestions = [];
  List<JiraIssue> _jiraSuggestions = [];
  Timer? _debounce;
  ClickUpTask? _selectedClickUpTask;
  JiraIssue? _selectedJiraIssue;
  OverlayEntry? _suggestionsOverlay;
  final LayerLink _layerLink = LayerLink();

  @override
  void initState() {
    super.initState();
    _loadEditingEntry();
    _descriptionController.addListener(_onDescriptionChanged);
    _descriptionFocusNode.addListener(_onFocusChanged);
  }

  @override
  void didUpdateWidget(covariant TimeEntryForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.editingEntry != oldWidget.editingEntry) {
      _loadEditingEntry();
    }
  }

  void _loadEditingEntry() {
    if (widget.editingEntry != null) {
      _descriptionController.text = widget.editingEntry!.description;
      _selectedDuration = widget.editingEntry!.durationMinutes;
      _selectedProjectId = widget.editingEntry!.projectId;
      _selectedTagIds = List.from(widget.editingEntry!.tagIds);
      _selectedStartTime =
          widget.editingEntry!.startTime != null
              ? TimeOfDay.fromDateTime(widget.editingEntry!.startTime!)
              : null;
      _startTimeController.text =
          _selectedStartTime != null
              ? _formatTimeOfDay(_selectedStartTime!)
              : '';
    } else {
      _clearForm();
    }
    setState(() {});
  }

  void _clearForm() {
    _descriptionController.text = widget.initialDescription?.trim() ?? '';
    _startTimeController.clear();
    _selectedDuration = null;
    _selectedProjectId = null;
    _selectedTagIds = [];
    _selectedClickUpTask = null;
    _selectedJiraIssue = null;
    _selectedStartTime = null;
    _descriptionError = null;
    _durationError = null;
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _descriptionController.removeListener(_onDescriptionChanged);
    _descriptionFocusNode.removeListener(_onFocusChanged);
    _descriptionController.dispose();
    _descriptionFocusNode.dispose();
    _startTimeController.dispose();
    _hideSuggestions();
    super.dispose();
  }

  void updateState(VoidCallback fn) {
    if (!mounted) return;
    setState(fn);
  }

  void _onFocusChanged() {
    if (!_descriptionFocusNode.hasFocus) {
      // Delay hiding to allow tap on suggestion
      Future.delayed(const Duration(milliseconds: 200), () {
        if (!_descriptionFocusNode.hasFocus) {
          _hideSuggestions();
        }
      });
    }
  }

  void _onDescriptionChanged() {
    final query = _descriptionController.text;

    // Clear selected task if description changed manually
    if (_selectedClickUpTask != null &&
        query != _selectedClickUpTask!.displayName) {
      _selectedClickUpTask = null;
    }
    if (_selectedJiraIssue != null &&
        query != _selectedJiraIssue!.displayName) {
      _selectedJiraIssue = null;
    }

    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 100), () {
      _searchTasks(query);
    });
  }

  void _searchTasks(String query) {
    if (query.length < 2) {
      setState(() {
        _clickUpSuggestions = [];
        _jiraSuggestions = [];
      });
      _hideSuggestions();
      return;
    }

    final authProvider = widget.cubit.authDataProvider;

    // Synchronous local search - instant results from cache
    var clickUpResults = widget.cubit.searchClickUpTasksLocal(query, limit: 20);
    var jiraResults = widget.cubit.searchJiraIssuesLocal(query, limit: 20);

    // Filter by user's accessible projects (unless admin)
    if (!authProvider.isAdmin) {
      final currentMember = widget.cubit.getCurrentUserTeamMember();
      final accessibleProjects = widget.cubit.getProjectsForUser(
        hasManagerAccess: authProvider.hasManagerAccess,
        teamMemberId: currentMember?.id,
      );

      // Get all clickUpListIds from accessible projects
      final accessibleListIds = <String>{};
      for (final project in accessibleProjects) {
        accessibleListIds.addAll(project.clickUpListIds);
      }

      // Filter tasks to only those from accessible lists
      if (accessibleListIds.isNotEmpty) {
        clickUpResults =
            clickUpResults
                .where(
                  (task) =>
                      task.listId != null &&
                      accessibleListIds.contains(task.listId),
                )
                .toList();
      } else {
        // User has no projects with ClickUp lists assigned - show nothing
        clickUpResults = [];
      }
    }

    // Limit to 4 results after filtering
    clickUpResults = clickUpResults.take(4).toList();
    jiraResults = jiraResults.take(4).toList();

    if (mounted && _descriptionController.text == query) {
      setState(() {
        _clickUpSuggestions = clickUpResults;
        _jiraSuggestions = jiraResults;
      });
      if ((clickUpResults.isNotEmpty || jiraResults.isNotEmpty) &&
          _descriptionFocusNode.hasFocus) {
        _showSuggestions();
      } else {
        _hideSuggestions();
      }
    }
  }

  void _showSuggestions() {
    _hideSuggestions();

    _suggestionsOverlay = OverlayEntry(
      builder:
          (context) => Positioned(
            width: 400,
            child: CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              offset: const Offset(0, 60),
              child: Material(
                color: Colors.transparent,
                child: _buildSuggestionsDropdown(),
              ),
            ),
          ),
    );

    Overlay.of(context).insert(_suggestionsOverlay!);
  }

  void _hideSuggestions() {
    _suggestionsOverlay?.remove();
    _suggestionsOverlay = null;
  }

  Widget _buildSuggestionsDropdown() {
    if (_clickUpSuggestions.isEmpty && _jiraSuggestions.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      constraints: const BoxConstraints(maxHeight: 280),
      decoration: BoxDecoration(
        color: AppTheme.cardDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.primaryAccent.withValues(alpha: 0.5),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(vertical: 4),
                itemCount:
                    _clickUpSuggestions.length +
                    _jiraSuggestions.length +
                    (_clickUpSuggestions.isNotEmpty ? 1 : 0) +
                    (_jiraSuggestions.isNotEmpty ? 1 : 0),
                itemBuilder: (context, index) {
                  var cursor = 0;

                  if (_clickUpSuggestions.isNotEmpty) {
                    if (index == cursor) {
                      return _buildSuggestionsHeader(
                        icon: Icons.task_alt,
                        label: 'ClickUp Tasks',
                        count: _clickUpSuggestions.length,
                        color: AppTheme.primaryAccent,
                      );
                    }
                    cursor++;

                    if (index < cursor + _clickUpSuggestions.length) {
                      final task = _clickUpSuggestions[index - cursor];
                      return _buildTaskSuggestionItem(task);
                    }
                    cursor += _clickUpSuggestions.length;
                  }

                  if (_jiraSuggestions.isNotEmpty) {
                    if (index == cursor) {
                      return _buildSuggestionsHeader(
                        icon: Icons.bug_report_outlined,
                        label: 'Jira Issues',
                        count: _jiraSuggestions.length,
                        color: AppTheme.secondaryAccent,
                      );
                    }
                    cursor++;

                    final jiraIssue = _jiraSuggestions[index - cursor];
                    return _buildJiraSuggestionItem(jiraIssue);
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestionsHeader({
    required IconData icon,
    required String label,
    required int count,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        border: Border(bottom: BorderSide(color: AppTheme.borderDark)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
          const Spacer(),
          Text(
            '$count found',
            style: TextStyle(fontSize: 10, color: AppTheme.textMuted),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskSuggestionItem(ClickUpTask task) {
    final statusColor = AppTheme.colorFromHex(task.statusColor);

    return InkWell(
      onTap: () => _selectTask(task),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            // Status indicator
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: statusColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 10),
            // Task info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (task.customId != null) ...[
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryAccent.withValues(
                              alpha: 0.15,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            task.customId!,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.primaryAccent,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],
                      Expanded(
                        child: Text(
                          task.name,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.textPrimary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      // Status badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          task.status,
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w500,
                            color: statusColor,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // List name
                      if (task.listName != null &&
                          task.listName!.isNotEmpty) ...[
                        Icon(
                          Icons.folder_outlined,
                          size: 10,
                          color: AppTheme.textMuted,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            task.listName!,
                            style: const TextStyle(
                              fontSize: 10,
                              color: AppTheme.textMuted,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            // Arrow
            const Icon(
              Icons.arrow_forward_ios,
              size: 12,
              color: AppTheme.textMuted,
            ),
          ],
        ),
      ),
    );
  }

  void _selectTask(ClickUpTask task) {
    // Try to auto-select project based on task's list
    String? autoProjectId;
    if (task.listId != null) {
      final project = widget.cubit.getProjectByClickUpListId(task.listId!);
      if (project != null) {
        autoProjectId = project.id;
      }
    }

    setState(() {
      _selectedClickUpTask = task;
      _selectedJiraIssue = null;
      _descriptionController.text = task.displayName;
      _descriptionController.selection = TextSelection.fromPosition(
        TextPosition(offset: _descriptionController.text.length),
      );
      _clickUpSuggestions = [];
      _jiraSuggestions = [];

      // Auto-select project if found
      if (autoProjectId != null && _selectedProjectId == null) {
        _selectedProjectId = autoProjectId;
      }
    });
    _hideSuggestions();
  }

  Widget _buildJiraSuggestionItem(JiraIssue issue) {
    final statusColor = AppTheme.colorFromHex(issue.status.color);

    return InkWell(
      onTap: () => _selectJiraIssue(issue),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: statusColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.secondaryAccent.withValues(
                            alpha: 0.15,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          issue.key,
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.secondaryAccent,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          issue.summary,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.textPrimary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          issue.status.name,
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w500,
                            color: statusColor,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.folder_outlined,
                        size: 10,
                        color: AppTheme.textMuted,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          issue.project.name,
                          style: const TextStyle(
                            fontSize: 10,
                            color: AppTheme.textMuted,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 12,
              color: AppTheme.textMuted,
            ),
          ],
        ),
      ),
    );
  }

  void _selectJiraIssue(JiraIssue issue) {
    setState(() {
      _selectedJiraIssue = issue;
      _selectedClickUpTask = null;
      _descriptionController.text = issue.displayName;
      _descriptionController.selection = TextSelection.fromPosition(
        TextPosition(offset: _descriptionController.text.length),
      );
      _clickUpSuggestions = [];
      _jiraSuggestions = [];
    });
    _hideSuggestions();
  }

  bool get isEditing => widget.editingEntry != null;

  String _formatTimeOfDay(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  DateTime? _composeStartDateTime(DateTime baseDate) {
    if (_selectedStartTime == null) return null;
    return DateTime(
      baseDate.year,
      baseDate.month,
      baseDate.day,
      _selectedStartTime!.hour,
      _selectedStartTime!.minute,
    );
  }

  Future<void> _pickStartTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedStartTime ?? TimeOfDay.now(),
      builder: (context, child) {
        if (child == null) return const SizedBox.shrink();
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child,
        );
      },
    );
    if (picked == null) return;
    setState(() {
      _selectedStartTime = picked;
      _startTimeController.text = _formatTimeOfDay(picked);
    });
  }

  void _clearStartTime() {
    setState(() {
      _selectedStartTime = null;
      _startTimeController.clear();
    });
  }

  void _submit() {
    // Validate fields and set inline errors
    bool hasError = false;
    setState(() {
      _descriptionError =
          _descriptionController.text.isEmpty
              ? 'Please enter a description'
              : null;
      _durationError =
          _selectedDuration == null ? 'Please select duration' : null;
      hasError = _descriptionError != null || _durationError != null;
    });

    if (hasError) return;

    if (isEditing) {
      final startTime = _composeStartDateTime(widget.cubit.selectedDate);
      widget.cubit.updateTimeEntry(
        widget.editingEntry!.copyWith(
          description: _descriptionController.text,
          durationMinutes: _selectedDuration!,
          date: widget.cubit.selectedDate,
          projectId: _selectedProjectId,
          tagIds: _selectedTagIds,
          clickUpTaskId: _selectedClickUpTask?.id,
          jiraIssueKey: _selectedJiraIssue?.key,
          startTime: startTime,
        ),
      );
      AppToast.show(
        context,
        'Time entry updated successfully',
        type: AppToastType.success,
      );
    } else {
      final startTime = _composeStartDateTime(widget.cubit.selectedDate);
      widget.cubit.addTimeEntry(
        _descriptionController.text,
        _selectedDuration!,
        widget.cubit.selectedDate,
        projectId: _selectedProjectId,
        tagIds: _selectedTagIds,
        clickUpTaskId: _selectedClickUpTask?.id,
        jiraIssueKey: _selectedJiraIssue?.key,
        startTime: startTime,
      );
      AppToast.show(
        context,
        'Time entry added successfully',
        type: AppToastType.success,
      );
    }

    _clearForm();
    setState(() {});
    widget.onSaved?.call();
  }

  void _cancel() {
    _clearForm();
    setState(() {});
    widget.onCancelEdit?.call();
  }

  @override
  Widget build(BuildContext context) => _buildForm(context);

  void startTimerFromExternal() {
    _startTimer();
  }

  void _startTimer() {
    if (_descriptionController.text.isEmpty) {
      AppToast.show(
        context,
        'Please enter a description before starting the timer',
        type: AppToastType.error,
      );
      return;
    }

    widget.cubit.startTimer(
      description: _descriptionController.text,
      projectId: _selectedProjectId,
      tagIds: _selectedTagIds,
    );

    // Clear the form
    _clearForm();
    setState(() {});

    AppToast.show(context, 'Timer started!', type: AppToastType.success);
  }
}

// Project Dropdown with Search
