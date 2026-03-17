part of 'package:time_tracker/screens/time_tracking/time_tracking_screen.dart';

extension TimeEntryFormStateWidgets on TimeEntryFormState {
  Widget _buildForm(BuildContext context) {
    final authProvider = widget.cubit.authDataProvider;
    // Get filtered projects based on user role
    final currentMember = widget.cubit.getCurrentUserTeamMember();
    final filteredProjects = widget.cubit.getProjectsForUser(
      hasManagerAccess: authProvider.hasManagerAccess,
      teamMemberId: currentMember?.id,
    );

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isEditing ? AppTheme.warningAccent.withValues(alpha: 0.05) : AppTheme.cardDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isEditing ? AppTheme.warningAccent.withValues(alpha: 0.5) : AppTheme.borderDark,
          width: isEditing ? 2 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color:
                      isEditing
                          ? AppTheme.warningAccent.withValues(alpha: 0.1)
                          : AppTheme.primaryAccent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  isEditing ? Icons.edit : Icons.add_circle_outline,
                  color: isEditing ? AppTheme.warningAccent : AppTheme.primaryAccent,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isEditing ? 'Edit Time Entry' : 'Add Time Entry',
                      style: Theme.of(
                        context,
                      ).textTheme.titleMedium?.copyWith(color: isEditing ? AppTheme.warningAccent : null),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 12,
                          color: isEditing ? AppTheme.warningAccent : AppTheme.primaryAccent,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          DateFormat('EEEE, MMM d, yyyy').format(widget.cubit.selectedDate),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: isEditing ? AppTheme.warningAccent.withValues(alpha: 0.8) : AppTheme.primaryAccent,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          CompositedTransformTarget(
            link: _layerLink,
            child: TextField(
              controller: _descriptionController,
              focusNode: _descriptionFocusNode,
              onChanged: (_) {
                if (_descriptionError != null) {
                  updateState(() => _descriptionError = null);
                }
              },
              decoration: InputDecoration(
                hintText: 'What did you work on? (type to search ClickUp or Jira issues)',
                prefixIcon:
                    _selectedClickUpTask != null
                        ? const Icon(Icons.task_alt, color: AppTheme.successAccent)
                        : _selectedJiraIssue != null
                        ? const Icon(Icons.bug_report_outlined, color: AppTheme.secondaryAccent)
                        : const Icon(Icons.edit_outlined),
                suffixIcon:
                    _selectedClickUpTask != null || _selectedJiraIssue != null
                        ? IconButton(
                          icon: const Icon(Icons.clear, size: 18),
                          onPressed: () {
                            updateState(() {
                              _selectedClickUpTask = null;
                              _selectedJiraIssue = null;
                              _descriptionController.clear();
                            });
                          },
                          tooltip: 'Clear task',
                        )
                        : null,
                errorText: _descriptionError,
                errorStyle: const TextStyle(color: AppTheme.tertiaryAccent),
              ),
              maxLines: 4,
              minLines: 1,
            ),
          ),
          // Selected task indicator
          if (_selectedClickUpTask != null) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppTheme.successAccent.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppTheme.successAccent.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  Icon(Icons.link, size: 14, color: AppTheme.successAccent),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Linked to ClickUp: ${_selectedClickUpTask!.shortId}',
                      style: TextStyle(fontSize: 11, color: AppTheme.successAccent, fontWeight: FontWeight.w500),
                    ),
                  ),
                  if (_selectedClickUpTask!.url != null)
                    IconButton(
                      icon: const Icon(Icons.open_in_new, size: 14),
                      onPressed: () async {
                        final url = Uri.parse(_selectedClickUpTask!.url!);
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url, mode: LaunchMode.externalApplication);
                        }
                      },
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      color: AppTheme.successAccent,
                      tooltip: 'Open in ClickUp',
                    ),
                ],
              ),
            ),
          ],
          if (_selectedJiraIssue != null) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppTheme.secondaryAccent.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppTheme.secondaryAccent.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  Icon(Icons.link, size: 14, color: AppTheme.secondaryAccent),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Linked to Jira: ${_selectedJiraIssue!.shortId}',
                      style: TextStyle(fontSize: 11, color: AppTheme.secondaryAccent, fontWeight: FontWeight.w500),
                    ),
                  ),
                  if (_selectedJiraIssue!.url != null)
                    IconButton(
                      icon: const Icon(Icons.open_in_new, size: 14),
                      onPressed: () async {
                        final url = Uri.parse(_selectedJiraIssue!.url!);
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url, mode: LaunchMode.externalApplication);
                        }
                      },
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      color: AppTheme.secondaryAccent,
                      tooltip: 'Open in Jira',
                    ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 20),
          Text('Duration', style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppTheme.textSecondary)),
          const SizedBox(height: 12),
          DurationChips(
            selectedDuration: _selectedDuration,
            onSelected: (duration) {
              updateState(() {
                _selectedDuration = duration;
                _durationError = null;
              });
            },
          ),
          if (_durationError != null) ...[
            const SizedBox(height: 8),
            Text(_durationError!, style: const TextStyle(color: AppTheme.tertiaryAccent, fontSize: 12)),
          ],
          const SizedBox(height: 20),
          Text(
            'Start time (optional)',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppTheme.textSecondary),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _startTimeController,
            readOnly: true,
            onTap: _pickStartTime,
            decoration: InputDecoration(
              hintText: 'HH:mm',
              prefixIcon: const Icon(Icons.schedule_outlined),
              suffixIcon:
                  _selectedStartTime != null
                      ? IconButton(
                        tooltip: 'Clear start time',
                        icon: const Icon(Icons.clear, size: 18),
                        onPressed: _clearStartTime,
                      )
                      : null,
            ),
          ),
          if (_selectedStartTime != null && _selectedDuration != null) ...[
            const SizedBox(height: 8),
            Builder(
              builder: (context) {
                final start = _composeStartDateTime(widget.cubit.selectedDate)!;
                final end = start.add(Duration(minutes: _selectedDuration!));
                final preview = '${DateFormat('HH:mm').format(start)}–${DateFormat('HH:mm').format(end)}';
                return Text('Preview: $preview', style: const TextStyle(fontSize: 12, color: AppTheme.textMuted));
              },
            ),
          ],
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Project',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppTheme.textSecondary),
                    ),
                    const SizedBox(height: 8),
                    ProjectDropdown(
                      selectedProjectId: _selectedProjectId,
                      projects: filteredProjects,
                      onChanged: (value) {
                        updateState(() {
                          _selectedProjectId = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tags',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppTheme.textSecondary),
                    ),
                    const SizedBox(height: 8),
                    TagsDropdown(
                      selectedTagIds: _selectedTagIds,
                      tags: widget.cubit.tags,
                      onChanged: (value) {
                        updateState(() {
                          _selectedTagIds = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              if (isEditing) ...[
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _cancel,
                    icon: const Icon(Icons.close),
                    label: const Text('Cancel'),
                    style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 24)),
                  ),
                ),
                const SizedBox(width: 12),
              ],
              Expanded(
                flex: isEditing ? 2 : 1,
                child: ElevatedButton.icon(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isEditing ? AppTheme.warningAccent : AppTheme.primaryAccent,
                    padding: const EdgeInsets.symmetric(vertical: 24),
                  ),
                  icon: Icon(isEditing ? Icons.save : Icons.check),
                  label: Text(isEditing ? 'Save Entry' : 'Add Entry'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
