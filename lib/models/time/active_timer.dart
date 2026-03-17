import 'package:freezed_annotation/freezed_annotation.dart';

import '../converters/firestore_timestamp_converter.dart';

part 'active_timer.freezed.dart';
part 'active_timer.g.dart';

@freezed
class ActiveTimer with _$ActiveTimer {
  const ActiveTimer._();

  const factory ActiveTimer({
    required String description,
    String? projectId,
    @Default([]) List<String> tagIds,
    @FirestoreDateTimeConverter() required DateTime startTime,
    int? targetMinutes,
  }) = _ActiveTimer;

  factory ActiveTimer.fromJson(Map<String, dynamic> json) => _$ActiveTimerFromJson(json);
}
