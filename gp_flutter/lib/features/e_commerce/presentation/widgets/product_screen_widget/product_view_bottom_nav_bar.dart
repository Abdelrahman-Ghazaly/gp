import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp_flutter/core/app_constants/app_colors.dart';
import 'package:gp_flutter/features/chat/presentation/screens/chat_room.dart';
import 'package:gp_flutter/features/e_commerce/domain/entities/seller_entity.dart';

import '../../../../../core/utils/utilities.dart';
import '../../../../authentication/presentation/bloc/log_in_bloc/log_in_bloc.dart'
    as log_in;
import '../../../../chat/presentation/bloc/create_conversation_bloc/create_conversation_bloc.dart';
import 'product_screen_widgets.dart';

class ProductViewBottomNavBar extends StatelessWidget {
  const ProductViewBottomNavBar({super.key, required this.seller});
  final SellerEntity seller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Utilities.screenWidth,
      height: Utilities.screenHeight * 0.07,
      decoration: const BoxDecoration(
        color: AppColors.appGreemColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 9,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const BottomNavBarButton(
            text: 'SMS',
            icon: Icons.email_outlined,
          ),
          BlocListener<CreateConversationBloc, CreateConversationState>(
            listener: (context, state) {
              final logInState = context.read<log_in.LogInBloc>().state;

              if (logInState is log_in.Success) {
                if (state is Success) {
                  Utilities().pushTo(
                    context,
                    screen: ChatRoom(
                      conversationId: state.conversationId,
                      name: seller.name,
                      userId: logInState.userEntity.id!,
                      recieverId: seller.id,
                    ),
                  );
                }
              }
            },
            child: BottomNavBarButton(
              text: 'Chat',
              icon: Icons.chat_outlined,
              onTap: () {
                final logInState = context.read<log_in.LogInBloc>().state;
                if (logInState is log_in.Success) {
                  context.read<CreateConversationBloc>().add(
                        CreateConversationEvent(
                          userId: logInState.userEntity.id!,
                          accessToken: logInState.userEntity.accessToken!,
                          receiverId: seller.id,
                        ),
                      );
                }
              },
            ),
          ),
          const BottomNavBarButton(
            text: 'Call',
            icon: Icons.phone_outlined,
            isCall: true,
          ),
        ],
      ),
    );
  }
}
