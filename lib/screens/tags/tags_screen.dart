import 'package:flutter/material.dart';
import 'package:time_tracker/app_dependencies.dart';
import 'package:time_tracker/cubit/cubit_builder.dart';
import 'package:time_tracker/models/projects/tag.dart';
import 'package:time_tracker/screens/tags/cubit/tags_cubit.dart';
import 'package:time_tracker/screens/tags/cubit/tags_state.dart';
import 'package:time_tracker/screens/tags/widgets/tag_dialogs.dart';
import 'package:time_tracker/screens/tags/widgets/tags_empty_state.dart';
import 'package:time_tracker/screens/tags/widgets/tags_list.dart';
import 'package:time_tracker/widgets/app_toast.dart';

class TagsScreen extends StatefulWidget {
  const TagsScreen({super.key});

  static const List<String> tagColors = [
    '#10B981',
    '#06B6D4',
    '#3B82F6',
    '#6366F1',
    '#8B5CF6',
    '#EC4899',
    '#F43F5E',
    '#F97316',
    '#EAB308',
    '#22C55E',
  ];

  @override
  State<TagsScreen> createState() => _TagsScreenState();
}

class _TagsScreenState extends State<TagsScreen> {
  late final TagsCubit _cubit;
  String? _lastToastMessage;

  @override
  void initState() {
    super.initState();
    _cubit = TagsCubit(AppDependencies.instance.workspaceRepository, AppDependencies.instance.tagsRepository);
  }

  @override
  void dispose() {
    _cubit.dispose();
    super.dispose();
  }

  void _handleToast(TagsState state) {
    final message = state.toastMessage;
    if (message == null || message == _lastToastMessage) return;

    _lastToastMessage = message;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AppToast.show(context, message, type: state.toastType ?? AppToastType.info);
    });
    _cubit.clearToast();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 800;

    return CubitBuilder<TagsCubit, TagsState>(
      cubit: _cubit,
      builder: (context, state) {
        _handleToast(state);

        return Scaffold(
          backgroundColor: Colors.transparent,
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => _showAddTagDialog(context),
            icon: const Icon(Icons.add),
            label: const Text('New Tag'),
          ),
          body:
              state.tags.isEmpty
                  ? TagsEmptyState(onAddTag: () => _showAddTagDialog(context))
                  : TagsList(
                    tags: state.tags,
                    isDesktop: isDesktop,
                    entryCountFor: _cubit.entryCountFor,
                    onEditTag: (tag) => _showEditTagDialog(context, tag),
                    onDeleteTag: (tag) => _confirmDelete(context, tag),
                  ),
        );
      },
    );
  }

  void _showAddTagDialog(BuildContext context) {
    _showTagDialog(context, null);
  }

  void _showEditTagDialog(BuildContext context, Tag tag) {
    _showTagDialog(context, tag);
  }

  Future<void> _showTagDialog(BuildContext context, Tag? tag) async {
    await showTagDialog(context: context, tagColors: TagsScreen.tagColors, tag: tag, onSave: _cubit.saveTag);
  }

  void _confirmDelete(BuildContext context, Tag tag) {
    showDeleteTagDialog(context: context, tag: tag, onDelete: _cubit.deleteTag);
  }
}
