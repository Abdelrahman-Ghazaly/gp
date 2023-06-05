import 'package:dio/dio.dart';
import 'package:gp_flutter/core/app_constants/api_constants.dart';
import 'package:gp_flutter/features/chat/data/models/conversation_model.dart';
import 'package:gp_flutter/features/chat/data/models/message_model.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/error_message_model.dart';
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

  Future<String> createConversation({
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

  Future<String> getUserName({
    required String userId,
  });
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final Dio dio;

  ChatRemoteDataSourceImpl({
    required this.dio,
  });

  @override
  Future<String> createConversation({
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
    if (response.statusCode == 200) {
      return response.data['_id'];
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel(
          statusCode: response.statusCode!,
          statusMessage: response.statusMessage!,
        ),
      );
    }
  }

  @override
  Future<List<ConversationEntity>> getConversations({
    required String userId,
    required String accessToken,
  }) async {
    Response response = await dio.get(
      ApiConstants.getConversationUrl(userId),
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
      return List.from(
        (response.data).map((element) => ConversationModel.fromMap(element)),
      );
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel(
          statusCode: response.statusCode!,
          statusMessage: response.statusMessage!,
        ),
      );
    }
  }

  @override
  Future<List<MessageEntity>> getMessages({
    required String conversationId,
    required String accessToken,
  }) async {
    Response response = await dio.get(
      ApiConstants.getMessagesUrl(conversationId),
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
      return List.from(
        (response.data).map((element) => MessageModel.fromMap(element)),
      );
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel(
          statusCode: response.statusCode!,
          statusMessage: response.statusMessage!,
        ),
      );
    }
  }

  @override
  Future<void> sendMessage({
    required String message,
    required String conversationId,
    required String userId,
    required String accessToken,
  }) async {
    Map data = {
      'sender': userId,
      'text': message,
      'conversationId': conversationId,
    };

    Response response = await dio.post(
      ApiConstants.sendMessageUrl,
      options: Options(
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

    if (response.statusCode != 200) {
      throw ServerException(
        errorMessageModel: ErrorMessageModel(
          statusCode: response.statusCode!,
          statusMessage: response.statusMessage!,
        ),
      );
    }
  }

  @override
  Future<String> getUserName({required String userId}) async {
    Response response = await dio.get(
      ApiConstants.getUserNameUrl(userId),
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status! < 600;
        },
      ),
    );
    if (response.statusCode == 200) {
      return response.data['name'];
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel(
          statusCode: response.statusCode!,
          statusMessage: response.statusMessage!,
        ),
      );
    }
  }
}
