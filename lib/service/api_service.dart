import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/response_message.dart';

class ApiService {
  Future<ResponseMessage?> sendMessage(String userId, String query) async {
    try {
      final response = await http.post(
        Uri.parse('http://37d4-113-23-6-4.ngrok-free.app/v1/chat-messages/'),
        headers: <String, String>{
          'Authorization': 'Bearer app-l355z3VNc8r9vA6DdqrSY1li',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'inputs': {},
          'query': query,
          'response_mode': 'blocking',
          'conversation_id': '',
          'user': userId
        }),
      );


      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        if (responseBody['data'] != null && responseBody['data'].isNotEmpty) {
          return ResponseMessage.fromJson(responseBody['data'][0]);
        } else {
          print('Response data is empty.');
          return null;
        }
      } else {
        print('Failed to send message: ${response.body}');
        print (response.statusCode);
        print (response.headers);
        print (response.body);
        return null;
      }
    } catch (e) {
      print('Error while sending message: $e');
      return null;
    }
  }
}
