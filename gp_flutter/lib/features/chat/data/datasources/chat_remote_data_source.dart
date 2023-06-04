import 'package:dio/dio.dart';
import 'package:gp_flutter/core/app_constants/api_constants.dart';

import '../../domain/entities/conversation_entity.dart';
import '../../domain/entities/message_entity.dart';

abstract class ChatRemoteDataSource {
  Future<List<ConversationEntity>> getConversations({
    required String userId,
    required String accessToken,
  });

  Future<List<MessageEntity>> getMessages({
    required String conversationId,
    required String accessToken,
  });

  Future<void> createConversation({
    required String userId,
    required String receiverId,
    required String accessToken,
  });

  Future<void> sendMessage({
    required String message,
    required String conversationId,
    required String userId,
    required String accessToken,
  });
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final Dio dio;

  ChatRemoteDataSourceImpl({
    required this.dio,
  });

  @override
  Future<void> createConversation({
    required String userId,
    required String receiverId,
    required String accessToken,
  }) async {
    Map data = {
      'senderId': userId,
      'receiverId': receiverId,
    };
    Response response = await dio.post(
      ApiConstants.createConversationUrl,
      options: Options(
        method: 'POST',
        followRedirects: false,
        validateStatus: (status) {
          return status! < 600;
        },
        headers: {
          'token': "Bearer $accessToken",
        },
      ),
      data: data,
    );
    if (response.statusCode == 200) {}
  }

  @override
  Future<List<ConversationEntity>> getConversations({
    required String userId,
    required String accessToken,
  }) async {
    Response response = await dio.get(
      ApiConstants.createConversationUrl,
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status! < 600;
        },
        headers: {
          'token': "Bearer $accessToken",
        },
      ),
    );
    if (response.statusCode == 200) {
      print(response.data);
      return [];
    }
    return [];
  }

  @override
  Future<List<MessageEntity>> getMessages({
    required String conversationId,
    required String accessToken,
  }) {
    // TODO: implement getMessages
    throw UnimplementedError();
  }

  @override
  Future<void> sendMessage({
    required String message,
    required String conversationId,
    required String userId,
    required String accessToken,
  }) {
    // TODO: implement sendMessage
    throw UnimplementedError();
  }
}
