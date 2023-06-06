import 'package:flutter/material.dart';
import 'package:gp_flutter/core/utils/utilities.dart';
import 'package:gp_flutter/features/chat/domain/entities/conversation_entity.dart';
import 'package:gp_flutter/features/chat/presentation/screens/chat_room.dart';

import '../../../../core/app_constants/app_constants.dart';

class UserCard extends StatelessWidget {
  const UserCard({
    super.key,
    required this.name,
    required this.conversation,
    required this.userId,
  });

  final String name;
  final ConversationEntity conversation;
  final String userId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Utilities().pushTo(
          context,
          screen: ChatRoom(
            conversationId: conversation.conversationId,
            name: name,
            userId: userId,
            recieverId: conversation.recieverId == userId
                ? conversation.senderId
                : conversation.recieverId,
          ),
        );
      },
      child: Container(
        height: 100,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                blurRadius: 15,
                color: Colors.black.withOpacity(0.2),
                offset: const Offset(0.5, 0.5),
              ),
            ]),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Center(
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.appGreemColor,
                  radius: 40,
                  child: Text(
                    name[0].toUpperCase(),
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                kSpacing(20),
                Text(
                  name,
                  style: AppTextStyles.appBarTextStyle,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
