import 'package:flutter/material.dart';
import 'package:time_tracker/models/projects/project.dart';
import 'package:time_tracker/screens/projects/cubit/projects_state.dart';
import 'package:time_tracker/screens/projects/widgets/project_card.dart';

class ProjectsGrid extends StatelessWidget {
  const ProjectsGrid({
    super.key,
    required this.cards,
    required this.isDesktop,
    required this.onTap,
    required this.onDelete,
  });

  final List<ProjectCardData> cards;
  final bool isDesktop;
  final void Function(Project project) onTap;
  final void Function(Project project) onDelete;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final mainAxisExtent =
            maxWidth > 1200
                ? 168.0
                : maxWidth > 900
                ? 172.0
                : maxWidth > 600
                ? 176.0
                : 182.0;

        return GridView.builder(
          padding: EdgeInsets.all(isDesktop ? 24 : 12),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: maxWidth > 900 ? 430 : 520,
            mainAxisExtent: mainAxisExtent,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: cards.length,
          itemBuilder: (context, index) {
            final card = cards[index];

            return ProjectCard(card: card, onTap: () => onTap(card.project), onDelete: () => onDelete(card.project));
          },
        );
      },
    );
  }
}
