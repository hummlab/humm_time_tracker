import 'package:flutter/material.dart';
import 'package:time_tracker/models/org/team_member.dart';
import 'package:time_tracker/screens/team/cubit/team_state.dart';
import 'package:time_tracker/screens/team/widgets/team_member_card.dart';

class TeamMembersGrid extends StatelessWidget {
  const TeamMembersGrid({
    super.key,
    required this.cards,
    required this.isDesktop,
    required this.onTap,
    required this.onDelete,
  });

  final List<TeamMemberCardData> cards;
  final bool isDesktop;
  final void Function(TeamMember member) onTap;
  final void Function(TeamMember member) onDelete;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount;
        double childAspectRatio;
        if (constraints.maxWidth > 900) {
          crossAxisCount = 3;
          childAspectRatio = 2.8;
        } else if (constraints.maxWidth > 500) {
          crossAxisCount = 2;
          childAspectRatio = 2.4;
        } else {
          crossAxisCount = 1;
          childAspectRatio = 3.0;
        }

        return GridView.builder(
          padding: EdgeInsets.all(isDesktop ? 32 : 16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: childAspectRatio,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: cards.length,
          itemBuilder: (context, index) {
            final card = cards[index];
            return TeamMemberCard(card: card, onTap: () => onTap(card.member), onDelete: () => onDelete(card.member));
          },
        );
      },
    );
  }
}
