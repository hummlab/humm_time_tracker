import 'package:time_tracker/cubit/base_cubit.dart';
import 'package:time_tracker/data_repositories/firebase/tags_repository.dart';
import 'package:time_tracker/data_repositories/workspace_repository.dart';
import 'package:time_tracker/models/projects/tag.dart';
import 'package:time_tracker/widgets/app_toast.dart';

import 'tags_state.dart';

class TagsCubit extends BaseCubit<TagsState> {
  TagsCubit(this._workspaceRepository, this._tagsRepository)
    : super(TagsState.initial()) {
    _workspaceRepository.addListener(_syncFromSources);
    _syncFromSources();
  }

  final WorkspaceRepository _workspaceRepository;
  final TagsRepository _tagsRepository;

  void _syncFromSources() {
    final tags = _workspaceRepository.tags;
    final counts = <String, int>{};

    for (final entry in _workspaceRepository.timeEntries) {
      for (final tagId in entry.tagIds) {
        counts[tagId] = (counts[tagId] ?? 0) + 1;
      }
    }

    emit(state.copyWith(tags: tags, entryCountsByTagId: counts));
  }

  int entryCountFor(String tagId) {
    return state.entryCountsByTagId[tagId] ?? 0;
  }

  Future<bool> saveTag({
    Tag? existing,
    required String name,
    required String color,
  }) async {
    final trimmedName = name.trim();
    if (trimmedName.isEmpty) {
      emit(
        state.copyWith(
          toastMessage: 'Please enter a tag name',
          toastType: AppToastType.error,
        ),
      );
      return false;
    }

    emit(state.copyWith(isProcessing: true));

    final success =
        existing == null
            ? await _tagsRepository.addTagSafe(
              Tag(
                id: '',
                name: trimmedName,
                color: color,
                createdAt: DateTime.now(),
              ),
            )
            : await _tagsRepository.updateTagSafe(
              existing.copyWith(name: trimmedName, color: color),
            );

    emit(state.copyWith(isProcessing: false));

    if (!success) {
      emit(
        state.copyWith(
          toastMessage:
              existing == null
                  ? 'Failed to create tag'
                  : 'Failed to update tag',
          toastType: AppToastType.error,
        ),
      );
      return false;
    }

    return true;
  }

  Future<void> deleteTag(Tag tag) async {
    emit(state.copyWith(isProcessing: true));
    final success = await _tagsRepository.deleteTagSafe(tag.id);
    emit(state.copyWith(isProcessing: false));

    if (!success) {
      emit(
        state.copyWith(
          toastMessage: 'Failed to delete tag',
          toastType: AppToastType.error,
        ),
      );
    }
  }

  void clearToast() {
    if (state.toastMessage == null && state.toastType == null) return;
    emit(state.copyWith(toastMessage: null, toastType: null));
  }

  @override
  void dispose() {
    _workspaceRepository.removeListener(_syncFromSources);
    super.dispose();
  }
}
