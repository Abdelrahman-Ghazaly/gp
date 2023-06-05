import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp_flutter/core/app_constants/app_constants.dart';
import 'package:gp_flutter/core/common_widgets/common_widgets.dart';
import 'package:gp_flutter/core/utils/utilities.dart';
import 'package:gp_flutter/features/authentication/presentation/bloc/log_in_bloc/log_in_bloc.dart'
    as log_in;
import 'package:gp_flutter/features/chat/presentation/bloc/get_messages_bloc/get_messages_bloc.dart';
import 'package:gp_flutter/features/chat/presentation/bloc/send_message_bloc/send_message_bloc.dart'
    as send;
import 'package:timeago/timeago.dart' as timeago;

class ChatRoom extends StatefulWidget {
  const ChatRoom({
    Key? key,
    required this.conversationId,
    required this.name,
  }) : super(key: key);
  final String conversationId;
  final String name;

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  late TextEditingController message;

  @override
  void initState() {
    super.initState();
    message = TextEditingController();
  }

  @override
  void dispose() {
    message.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final logInState = context.read<log_in.LogInBloc>().state;
    List myMessages = [];
    List messages = [];

    if (logInState is log_in.Success) {
      context.read<GetMessagesBloc>().add(
            GetMessagesEvent(
              conversationId: widget.conversationId,
              accessToken: logInState.userEntity.accessToken!,
            ),
          );

      bool isMyMessage(message) {
        return myMessages.contains(message);
      }

      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.name),
        ),
        body: SingleChildScrollView(
          child: BlocBuilder<GetMessagesBloc, GetMessagesState>(
            builder: (context, state) {
              if (state is Success) {
                myMessages = List.from(
                  (state.messages).map(
                    (message) {
                      if (message.senderId == logInState.userEntity.id) {
                        return message;
                      }
                    },
                  ),
                );
                return Column(
                  children: [
                    SizedBox(
                      height: Utilities.screenHeight * 0.8,
                      width: Utilities.screenWidth,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ListView.separated(
                          reverse: true,
                          itemCount: state.messages.length,
                          separatorBuilder: (BuildContext context, int index) =>
                              kSpacing(10),
                          itemBuilder: (BuildContext context, int index) {
                            messages = List.from(state.messages.reversed);
                            return isMyMessage(state.messages[index])
                                ? Align(
                                    alignment: Alignment.centerRight,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                bottomLeft: Radius.circular(12),
                                                topLeft: Radius.circular(12),
                                                topRight: Radius.circular(12),
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 20,
                                                  color: Colors.black
                                                      .withOpacity(0.4),
                                                  offset:
                                                      const Offset(0.5, 0.5),
                                                )
                                              ]),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child:
                                                Text(messages[index].message),
                                          ),
                                        ),
                                        Text(
                                          _timeStamp(messages[index].createdAt),
                                        ),
                                      ],
                                    ),
                                  )
                                : Align(
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                bottomLeft: Radius.circular(12),
                                                topLeft: Radius.circular(12),
                                                topRight: Radius.circular(12),
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 20,
                                                  color: Colors.black
                                                      .withOpacity(0.4),
                                                  offset:
                                                      const Offset(0.5, 0.5),
                                                )
                                              ]),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child:
                                                Text(messages[index].message),
                                          ),
                                        ),
                                        Text(
                                          _timeStamp(messages[index].createdAt),
                                        ),
                                      ],
                                    ),
                                  );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Utilities.screenHeight * 0.1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: Utilities.screenWidth * 0.8,
                            child: TextField(
                              controller: message,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                    width: 1.5,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                    width: 1.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          FloatingActionButton(
                            onPressed: () {
                              if (message.text.isNotEmpty) {
                                context.read<send.SendMessageBloc>().add(
                                      send.SendMessageEvent(
                                        message: message.text,
                                        conversationId: widget.conversationId,
                                        userId: logInState.userEntity.id!,
                                        accessToken:
                                            logInState.userEntity.accessToken!,
                                      ),
                                    );
                                messages.add(message.text);
                                setState(() {});
                                message.clear();
                              }
                            },
                            child: const Icon(
                              Icons.send,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return const LoadingWidget();
              }
            },
          ),
        ),
      );
    }
    return Container();
  }
}

String _timeStamp(String time) {
  return timeago.format(
    DateTime.now().subtract(
      DateTime.now().difference(
        DateTime.parse(time),
      ),
    ),
  );
}
