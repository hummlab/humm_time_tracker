part of 'package:time_tracker/screens/time_tracking/time_tracking_screen.dart';

extension _TimeTrackingScreenSections on _TimeTrackingScreenState {
  Widget _buildStartTimerCard(TimeTrackingState state) {
    if (state.hasActiveTimer || state.editingEntry != null) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.successAccent.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.successAccent.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.timer_outlined, color: AppTheme.successAccent, size: 20),
              ),
              const SizedBox(width: 12),
              Text(
                'Start Timer',
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(color: AppTheme.textPrimary, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Track time in real-time with a running timer.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppTheme.textMuted),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {
              _timeEntryFormKey.currentState?.startTimerFromExternal();
            },
            icon: const Icon(Icons.play_arrow),
            label: const Text('Start Timer'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.successAccent,
              foregroundColor: AppTheme.primaryDark,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEntriesList(TimeTrackingState state) {
    var entries = _cubit.entriesForDate(state.selectedDate, currentUserOnly: true);

    if (entries.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: AppTheme.cardDark,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppTheme.borderDark),
        ),
        child: Column(
          children: [
            Icon(Icons.hourglass_empty, size: 48, color: AppTheme.textMuted),
            const SizedBox(height: 16),
            Text(
              'No entries for ${DateFormat('EEEE, MMM d').format(state.selectedDate)}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Add a new time entry using the form above.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppTheme.textMuted),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Entries for ${DateFormat('MMM d').format(state.selectedDate)}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Spacer(),
            Text(
              '${entries.fold<int>(0, (sum, e) => sum + e.durationMinutes)} min',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.primaryAccent),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Column(
          children: [
            for (final entry in entries)
              TimeEntryListItem(
                entry: entry,
                project: entry.projectId != null ? _cubit.getProjectById(entry.projectId!) : null,
                tags: entry.tagIds.map((id) => _cubit.getTagById(id)).whereType<Tag>().toList(),
                isEditing: state.editingEntry?.id == entry.id,
                onTap: () => _startEditing(entry),
                onDelete: () {
                  _cubit.deleteTimeEntry(entry.id);
                },
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildDaySummary(TimeTrackingState state) {
    final weekEntries = _cubit.weekEntries(currentUserOnly: true);

    final totalWeekMinutes = weekEntries.fold(0, (sum, entry) => sum + entry.durationMinutes);

    final totalWeekHours = totalWeekMinutes / 60;
    final averagePerDay = totalWeekMinutes / 7;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.cardDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderDark),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Week Summary', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildStatCard('Total', '${totalWeekHours.toStringAsFixed(1)}h', AppTheme.primaryAccent),
              const SizedBox(width: 12),
              _buildStatCard('Avg/Day', '${(averagePerDay / 60).toStringAsFixed(1)}h', AppTheme.warningAccent),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildStatCard('Entries', '${weekEntries.length}', AppTheme.successAccent),
              const SizedBox(width: 12),
              _buildStatCard(
                'Projects',
                '${weekEntries.map((e) => e.projectId).whereType<String>().toSet().length}',
                AppTheme.tertiaryAccent,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: 0.3)),
          const SizedBox(height: 4),
          Text(value, style: TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}
