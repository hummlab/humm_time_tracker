part of 'package:time_tracker/screens/time_tracking/time_tracking_screen.dart';

extension _TimeTrackingScreenSections on _TimeTrackingScreenState {
  Widget _buildStartTimerCard(TimeTrackingState state) {
    if (state.hasActiveTimer || state.editingEntry != null) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.successAccent.withValues(alpha: 0.12),
            AppTheme.cardDark,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.successAccent.withValues(alpha: 0.5),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: AppTheme.successAccent.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.timer_outlined,
              color: AppTheme.successAccent,
              size: 18,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Start Timer',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: AppTheme.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Track in real-time',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.textMuted,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          FilledButton.icon(
            onPressed: () {
              showQuickTimerSheet();
            },
            icon: const Icon(Icons.play_arrow, size: 16),
            label: const Text('Start'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.successAccent,
              foregroundColor: AppTheme.primaryDark,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              minimumSize: const Size(0, 34),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEntriesList(TimeTrackingState state) {
    var entries = _cubit.entriesForDate(
      state.selectedDate,
      currentUserOnly: true,
    );

    if (entries.isEmpty) {
      final allVisibleEntries = _cubit.timeDataProvider.timeEntries;
      final pendingCount =
          allVisibleEntries.where((entry) => entry.isPending).length;
      final rejectedCount =
          allVisibleEntries.where((entry) => entry.isRejected).length;
      final todayTeamEntries =
          _cubit.timeDataProvider.getEntriesForDate(DateTime.now()).length;

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 26),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'No entries for ${DateFormat('EEE, MMM d').format(state.selectedDate)}',
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppTheme.textMuted),
              ),
              if (state.hasManagerAccess) ...[
                const SizedBox(height: 12),
                _buildAdminMiniWidget(
                  pendingCount: pendingCount,
                  rejectedCount: rejectedCount,
                  todayEntriesCount: todayTeamEntries,
                ),
              ],
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Entries for ${DateFormat('MMM d').format(state.selectedDate)}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '${entries.fold<int>(0, (sum, e) => sum + e.durationMinutes)} min',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.white60,
                fontSize: 12,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Column(
          children: [
            for (var i = 0; i < entries.length; i++) ...[
              TimeEntryListItem(
                entry: entries[i],
                project:
                    entries[i].projectId != null
                        ? _cubit.getProjectById(entries[i].projectId!)
                        : null,
                tags:
                    entries[i].tagIds
                        .map((id) => _cubit.getTagById(id))
                        .whereType<Tag>()
                        .toList(),
                isEditing: state.editingEntry?.id == entries[i].id,
                onTap: () => _startEditing(entries[i]),
                onDelete: () {
                  _cubit.deleteTimeEntry(entries[i].id);
                },
              ),
              if (i != entries.length - 1)
                const Divider(height: 1, color: Colors.white10),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildDaySummary(TimeTrackingState state) {
    final weekEntries = _cubit.weekEntries(currentUserOnly: true);

    final totalWeekMinutes = weekEntries.fold(
      0,
      (sum, entry) => sum + entry.durationMinutes,
    );

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
          LayoutBuilder(
            builder: (context, constraints) {
              const spacing = 12.0;
              final stats = [
                (
                  'Total',
                  '${totalWeekHours.toStringAsFixed(1)}h',
                  AppTheme.primaryAccent,
                ),
                (
                  'Avg/Day',
                  '${(averagePerDay / 60).toStringAsFixed(1)}h',
                  AppTheme.warningAccent,
                ),
                ('Entries', '${weekEntries.length}', AppTheme.successAccent),
                (
                  'Projects',
                  '${weekEntries.map((e) => e.projectId).whereType<String>().toSet().length}',
                  AppTheme.tertiaryAccent,
                ),
              ];

              final maxWidth = constraints.maxWidth;
              int columns = 2;
              if (maxWidth >= 980) {
                columns = 4;
              } else if (maxWidth < 360) {
                columns = 1;
              }

              final itemWidth =
                  (maxWidth - (spacing * (columns - 1))) / columns;

              return Wrap(
                spacing: spacing,
                runSpacing: spacing,
                children:
                    stats
                        .map(
                          (stat) => SizedBox(
                            width: itemWidth,
                            child: _buildStatCard(stat.$1, stat.$2, stat.$3),
                          ),
                        )
                        .toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, Color color) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdminMiniWidget({
    required int pendingCount,
    required int rejectedCount,
    required int todayEntriesCount,
  }) {
    Widget buildBadge(String label, String value, Color color) {
      return Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: const TextStyle(color: AppTheme.textMuted, fontSize: 10),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Admin Snapshot',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppTheme.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              buildBadge(
                'Pending approvals',
                '$pendingCount',
                AppTheme.warningAccent,
              ),
              const SizedBox(width: 6),
              buildBadge(
                'Rejected entries',
                '$rejectedCount',
                AppTheme.tertiaryAccent,
              ),
              const SizedBox(width: 6),
              buildBadge(
                'Entries today',
                '$todayEntriesCount',
                AppTheme.primaryAccent,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
