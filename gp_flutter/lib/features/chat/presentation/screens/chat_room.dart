// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp_flutter/core/app_constants/api_constants.dart';
import 'package:gp_flutter/core/app_constants/app_constants.dart';
import 'package:gp_flutter/core/common_widgets/common_widgets.dart';
import 'package:gp_flutter/core/utils/utilities.dart';
import 'package:gp_flutter/features/authentication/presentation/bloc/log_in_bloc/log_in_bloc.dart'
    as log_in;
import 'package:gp_flutter/features/chat/domain/entities/message_entity.dart';
import 'package:gp_flutter/features/chat/presentation/bloc/get_messages_bloc/get_messages_bloc.dart';
import 'package:gp_flutter/features/chat/presentation/bloc/send_message_bloc/send_message_bloc.dart'
    as send;
import 'package:timeago/timeago.dart' as timeago;
import 'package:socket_io_client/socket_io_client.dart' as io;

class ChatRoom extends StatefulWidget {
  const ChatRoom({
    Key? key,
    required this.conversationId,
    required this.name,
    required this.userId,
    required this.recieverId,
  }) : super(key: key);
  final String conversationId;
  final String name;
  final String userId;
  final String recieverId;

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  late io.Socket _socket;

  late TextEditingController messageController;

  @override
  void initState() {
    super.initState();

    _socket = io.io(
      ApiConstants.socketUrl,
      io.OptionBuilder().setTransports(
        ['websocket'],
      ).build(),
    );
    messageController = TextEditingController();
    _connectSocket();
  }

  _connectSocket() {
    _socket.on('connection', (data) => print('connected'));
    _socket.emit('addUser', widget.userId);

    _socket.onConnect((data) => print('Connection established'));
    _socket.onConnectError((data) => print('Connect Error: $data'));
  }

  @override
  void dispose() {
    messageController.dispose();
    _socket.emit("disconnect", (_) => print('disconnected'));
    _socket.onDisconnect((data) => print('Socket.IO server disconnected'));

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final logInState = context.read<log_in.LogInBloc>().state;

    List<MessageEntity> messages = [];

    sendMessage(messageMap) {
      _socket.emit(
        'sendMessage',
        messageMap,
      );
      _socket.on(
        'getMessage',
        (data) {
          final newMessage = MessageEntity(
            senderId: data['senderId'],
            message: data['text'],
            createdAt: DateTime.now().toString(),
            conversationId: widget.conversationId,
          );
          messages.add(newMessage);
          setState(() {});
          return null;
        },
      );
      messageController.clear();
    }

    if (logInState is log_in.Success) {
      context.read<GetMessagesBloc>().add(
            GetMessagesEvent(
              conversationId: widget.conversationId,
              accessToken: logInState.userEntity.accessToken!,
            ),
          );

      bool isMyMessage(MessageEntity message) {
        return message.senderId == logInState.userEntity.id;
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
                            return Align(
                              alignment: isMyMessage(messages[index])
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Column(
                                crossAxisAlignment: isMyMessage(messages[index])
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: isMyMessage(messages[index])
                                          ? Colors.grey
                                          : Colors.blue,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: isMyMessage(messages[index])
                                            ? const Radius.circular(12)
                                            : Radius.zero,
                                        topLeft: const Radius.circular(12),
                                        topRight: const Radius.circular(12),
                                        bottomRight:
                                            isMyMessage(messages[index])
                                                ? Radius.zero
                                                : const Radius.circular(12),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 20,
                                          color: Colors.black.withOpacity(0.4),
                                          offset: const Offset(0.5, 0.5),
                                        )
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Text(messages[index].message),
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
                              controller: messageController,
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
                              if (messageController.text.isNotEmpty) {
                                context.read<send.SendMessageBloc>().add(
                                      send.SendMessageEvent(
                                        message: messageController.text,
                                        conversationId: widget.conversationId,
                                        userId: logInState.userEntity.id!,
                                        accessToken:
                                            logInState.userEntity.accessToken!,
                                      ),
                                    );
                                messages.add(
                                  MessageEntity(
                                    senderId: logInState.userEntity.id!,
                                    message: messageController.text,
                                    createdAt: DateTime.now().toString(),
                                    conversationId: widget.conversationId,
                                  ),
                                );

                                Map messageMap = {
                                  'text': messageController.text,
                                  'senderId': logInState.userEntity.id!,
                                  'receiverId': widget.recieverId
                                };
                                setState(() {});
                                sendMessage(messageMap);
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
