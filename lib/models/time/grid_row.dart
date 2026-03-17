import 'package:freezed_annotation/freezed_annotation.dart';

part 'grid_row.freezed.dart';
part 'grid_row.g.dart';

@freezed
class GridRow with _$GridRow {
  const GridRow._();

  const factory GridRow({
    required String description,
    String? projectId,
    @Default([]) List<String> tagIds,
    @Default([]) List<int> dayMinutes,
    @Default([]) List<List<String>> dayEntryIds,
  }) = _GridRow;

  factory GridRow.fromJson(Map<String, dynamic> json) => _$GridRowFromJson(json);

  int get totalMinutes => dayMinutes.fold(0, (a, b) => a + b);
}
