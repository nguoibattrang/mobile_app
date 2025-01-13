import 'package:chatview/chatview.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:vcs_hackathon/data/data.dart';
import '../env/env.dart';

class ApiService {
  static String conversationId = "";

  Future<Message?> sendMessage(String query) async {
    try {
      final response = await http.post(
        Uri.parse(Data.url),
        headers: <String, String>{
          'Authorization': 'Bearer ${Env.apiKey}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'inputs': {},
          'query': query,
          'response_mode': 'blocking',
          'conversation_id': conversationId,
          'user': Data.userID
        }),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        if (responseBody?.isNotEmpty) {
          conversationId = responseBody['conversation_id'];
          String message = responseBody['answer'];
          DateTime createdTime = DateTime.now();
          return Message(
            id: createdTime.toString(),
            message: message,
            createdAt: createdTime,
            sentBy: Data.chatbotID
          );
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
