part of 'package:time_tracker/screens/time_tracking/time_tracking_screen.dart';

class ActiveTimerWidget extends StatefulWidget {
  const ActiveTimerWidget({
    super.key,
    required this.cubit,
    required this.state,
    this.onTap,
  });

  final TimeTrackingCubit cubit;
  final TimeTrackingState state;
  final VoidCallback? onTap;

  @override
  State<ActiveTimerWidget> createState() => _ActiveTimerWidgetState();
}

class _ActiveTimerWidgetState extends State<ActiveTimerWidget> {
  late Stream<int> _tickerStream;

  @override
  void initState() {
    super.initState();
    _tickerStream = Stream.periodic(const Duration(seconds: 1), (i) => i);
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.state.hasActiveTimer || widget.state.activeTimer == null) {
      return const SizedBox.shrink();
    }

    final timer = widget.state.activeTimer!;
    final project =
        timer.projectId != null
            ? widget.cubit.getProjectById(timer.projectId!)
            : null;
    final projectColor =
        project != null
            ? AppTheme.colorFromHex(project.color)
            : AppTheme.textMuted;

    return StreamBuilder<int>(
      stream: _tickerStream,
      builder: (context, snapshot) {
        final elapsed = DateTime.now().difference(timer.startTime);
        final hours = elapsed.inHours;
        final minutes = elapsed.inMinutes % 60;
        final seconds = elapsed.inSeconds % 60;

        String timeDisplay;
        if (hours > 0) {
          timeDisplay =
              '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
        } else {
          timeDisplay = '$minutes:${seconds.toString().padLeft(2, '0')}';
        }

        int totalMinutes = elapsed.inMinutes;
        final isUnderMinimum = totalMinutes < 15;
        if (isUnderMinimum) {
          totalMinutes = 15;
        } else {
          totalMinutes = ((totalMinutes + 14) ~/ 15) * 15;
        }

        final startFormatted = DateFormat('HH:mm').format(timer.startTime);

        return GestureDetector(
          onTap: widget.onTap,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.successAccent.withValues(alpha: 0.15),
                  AppTheme.successAccent.withValues(alpha: 0.05),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppTheme.successAccent.withValues(alpha: 0.5),
                width: 2,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppTheme.successAccent.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.timer,
                        color: AppTheme.successAccent,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Timer Running',
                      style: TextStyle(
                        color: AppTheme.successAccent,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    const Spacer(),
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.5, end: 1.0),
                      duration: const Duration(milliseconds: 800),
                      builder: (context, value, child) {
                        return Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: AppTheme.successAccent.withValues(
                              alpha: value,
                            ),
                            shape: BoxShape.circle,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Text(
                      timeDisplay,
                      style: Theme.of(
                        context,
                      ).textTheme.headlineMedium?.copyWith(
                        color: AppTheme.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Started at $startFormatted',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: AppTheme.textSecondary),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Will save: ${totalMinutes}m',
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(
                            color: AppTheme.warningAccent,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                if (timer.description.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Text(
                    timer.description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.textPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
                if (project != null) ...[
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: projectColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        project.name,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: 16),
                Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed:
                          widget.state.isStoppingTimer
                              ? null
                              : () => widget.cubit.stopTimer(),
                      icon: const Icon(Icons.stop),
                      label: Text(
                        widget.state.isStoppingTimer
                            ? 'Stopping...'
                            : 'Stop & Save',
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.successAccent,
                        foregroundColor: AppTheme.primaryDark,
                      ),
                    ),
                    const SizedBox(width: 10),
                    OutlinedButton.icon(
                      onPressed:
                          widget.state.isStoppingTimer
                              ? null
                              : () {
                                widget.cubit.cancelTimer();
                              },
                      icon: const Icon(Icons.close),
                      label: const Text('Cancel'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
