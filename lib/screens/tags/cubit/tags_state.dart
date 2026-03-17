import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:time_tracker/models/projects/tag.dart';
import 'package:time_tracker/widgets/app_toast.dart';

part 'tags_state.freezed.dart';

@freezed
class TagsState with _$TagsState {
  const factory TagsState({
    @Default([]) List<Tag> tags,
    @Default({}) Map<String, int> entryCountsByTagId,
    @Default(false) bool isProcessing,
    String? toastMessage,
    AppToastType? toastType,
  }) = _TagsState;

  factory TagsState.initial() => const TagsState();
}
