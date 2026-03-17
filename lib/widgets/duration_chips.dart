import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class DurationChips extends StatefulWidget {
  final int? selectedDuration;
  final Function(int) onSelected;

  const DurationChips({super.key, this.selectedDuration, required this.onSelected});

  static const List<int> durations = [15, 30, 60, 90, 120, 180, 240, 300, 360, 420, 480];

  @override
  State<DurationChips> createState() => _DurationChipsState();
}

class _DurationChipsState extends State<DurationChips> {
  final _customController = TextEditingController();
  final _focusNode = FocusNode();
  bool _isCustom = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
    _updateCustomState();
  }

  @override
  void didUpdateWidget(covariant DurationChips oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedDuration != oldWidget.selectedDuration) {
      _updateCustomState();
    }
  }

  void _updateCustomState() {
    if (widget.selectedDuration != null && !DurationChips.durations.contains(widget.selectedDuration)) {
      _isCustom = true;
      _customController.text = _formatDuration(widget.selectedDuration!);
    } else if (!_isCustom) {
      _customController.clear();
    }
  }

  void _onFocusChange() {
    if (!_focusNode.hasFocus && _customController.text.isNotEmpty) {
      _parseAndApply();
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _customController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  String _formatDuration(int minutes) {
    final hours = minutes ~/ 60;
    final mins = minutes % 60;
    if (hours > 0 && mins > 0) {
      return '${hours}h${mins}m';
    } else if (hours > 0) {
      return '${hours}h';
    } else {
      return '${mins}m';
    }
  }

  int? _parseDuration(String input) {
    if (input.isEmpty) return null;

    final normalized = input.toLowerCase().trim();

    // Just a number - treat as minutes
    final justNumber = RegExp(r'^(\d+)$');
    final justMatch = justNumber.firstMatch(normalized);
    if (justMatch != null) {
      return int.parse(justMatch.group(1)!);
    }

    // "Xh" or "XhYm" or "Xh Ym"
    final hoursPattern = RegExp(r'^(\d+)\s*h\s*(?:(\d+)\s*m?)?$');
    final hoursMatch = hoursPattern.firstMatch(normalized);
    if (hoursMatch != null) {
      final hours = int.parse(hoursMatch.group(1)!);
      final mins = hoursMatch.group(2) != null ? int.parse(hoursMatch.group(2)!) : 0;
      return hours * 60 + mins;
    }

    // "Xm"
    final minsPattern = RegExp(r'^(\d+)\s*m$');
    final minsMatch = minsPattern.firstMatch(normalized);
    if (minsMatch != null) {
      return int.parse(minsMatch.group(1)!);
    }

    // "X:Y" format like "1:30" for 1h 30m
    final colonPattern = RegExp(r'^(\d+):(\d+)$');
    final colonMatch = colonPattern.firstMatch(normalized);
    if (colonMatch != null) {
      final hours = int.parse(colonMatch.group(1)!);
      final mins = int.parse(colonMatch.group(2)!);
      return hours * 60 + mins;
    }

    return null;
  }

  void _parseAndApply() {
    final minutes = _parseDuration(_customController.text);
    if (minutes != null && minutes > 0) {
      setState(() => _isCustom = true);
      _customController.text = _formatDuration(minutes);
      widget.onSelected(minutes);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children:
              DurationChips.durations.map((duration) {
                final isSelected = widget.selectedDuration == duration && !_isCustom;
                return _buildChip(context, duration, isSelected);
              }).toList(),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            SizedBox(
              width: 100,
              child: TextField(
                controller: _customController,
                focusNode: _focusNode,
                decoration: InputDecoration(
                  hintText: '7h30m',
                  hintStyle: const TextStyle(fontSize: 13, color: AppTheme.textMuted),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: _isCustom ? AppTheme.primaryAccent : AppTheme.borderDark),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: _isCustom ? AppTheme.primaryAccent : AppTheme.borderDark),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppTheme.primaryAccent, width: 2),
                  ),
                  filled: true,
                  fillColor: _isCustom ? AppTheme.primaryAccent.withValues(alpha: 0.1) : AppTheme.surfaceDark,
                ),
                style: TextStyle(
                  fontSize: 13,
                  color: _isCustom ? AppTheme.primaryAccent : AppTheme.textPrimary,
                  fontWeight: _isCustom ? FontWeight.w600 : FontWeight.w400,
                ),
                onSubmitted: (_) => _parseAndApply(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildChip(BuildContext context, int duration, bool isSelected) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      child: FilterChip(
        label: Text(_formatDuration(duration)),
        selected: isSelected,
        onSelected: (_) {
          setState(() {
            _isCustom = false;
            _customController.clear();
          });
          widget.onSelected(duration);
        },
        backgroundColor: AppTheme.surfaceDark,
        selectedColor: AppTheme.primaryAccent.withValues(alpha: 0.2),
        checkmarkColor: AppTheme.primaryAccent,
        labelStyle: TextStyle(
          color: isSelected ? AppTheme.primaryAccent : AppTheme.textSecondary,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
        ),
        side: BorderSide(color: isSelected ? AppTheme.primaryAccent : AppTheme.borderDark),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
