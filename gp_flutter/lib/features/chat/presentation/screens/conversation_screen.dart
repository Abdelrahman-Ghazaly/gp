import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp_flutter/core/app_constants/app_constants.dart';
import 'package:gp_flutter/core/common_widgets/common_widgets.dart';
import 'package:gp_flutter/features/authentication/presentation/screens/authentication_screen.dart';
import 'package:gp_flutter/features/chat/data/data_sources/chat_remote_data_source.dart';
import 'package:gp_flutter/features/chat/presentation/bloc/get_conversation_bloc/get_conversation_bloc.dart';
import 'package:gp_flutter/features/chat/presentation/bloc/get_user_name_bloc/get_user_name_bloc.dart'
    as user_name;

import '../../../authentication/presentation/bloc/log_in_bloc/log_in_bloc.dart'
    as log_in;
import '../widgets/user_card.dart';

List<String> otherUsers = [];

class ConversationScreen extends StatelessWidget {
  const ConversationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logInState = context.read<log_in.LogInBloc>().state;

    if (logInState is log_in.Success) {
      context.read<GetConversationsBloc>().add(
            GetConversationEvent(
              accessToken: logInState.userEntity.accessToken!,
              userId: logInState.userEntity.id!,
            ),
          );

      return BlocBuilder<GetConversationsBloc, GetConversationState>(
        builder: (context, state) {
          if (state is Success) {
            final othersId = List.from(
              (state.conversations).map(
                (converstion) {
                  return converstion.recieverId == logInState.userEntity.id
                      ? converstion.senderId
                      : converstion.recieverId;
                },
              ),
            );

            final userName = context.read<user_name.GetUserNameBloc>();

            return Padding(
              padding: const EdgeInsets.all(10),
              child: ListView.builder(
                itemCount: state.conversations.length,
                itemBuilder: (context, index) {
                  userName.add(
                    user_name.GetUserNameEvent(userId: othersId[index]),
                  );

                  _getUserName(othersId[index]);

                  return BlocBuilder<user_name.GetUserNameBloc,
                      user_name.GetUserNameState>(
                    builder: (context, userNameState) {
                      if (userNameState is user_name.Success) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: UserCard(
                            name: otherUsers.elementAt(index),
                            conversation: state.conversations[index],
                          ),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            height: 100,
                            width: 100,
                            color: Colors.white,
                            child: const Center(child: LoadingWidget()),
                          ),
                        );
                      }
                    },
                  );
                },
              ),
            );
          } else if (state is Error) {
            return Center(
              child: Text(
                state.message,
                style: AppTextStyles.titileTextStyle,
              ),
            );
          } else if (state is Empty) {
            return Center(
              child: Text(
                'There are no conversation in here',
                style: AppTextStyles.titileTextStyle,
              ),
            );
          } else {
            return const LoadingWidget();
          }
        },
      );
    } else {
      return const AuthenticationScreen();
    }
  }
}

void _getUserName(String id) async {
  otherUsers.add(
    await ChatRemoteDataSourceImpl(dio: Dio()).getUserName(userId: id),
  );
}
