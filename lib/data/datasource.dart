import 'package:http/http.dart' as http;
import 'dart:convert';

class MeChatDatasource {
  static const url = 'http://127.0.0.1:8080';

  Future<String> getUsername(String username) async {
    var response = await http.get(Uri.parse('$url/api/user/$username'));
    return response.body;
  }

  Future<String> getRoom(String username) async {
    var response = await http.get(Uri.parse('$url/api/room/$username'));
    return response.body;
  }

  Future<String> getChat(String roomId) async {
    var response = await http.get(Uri.parse('$url/api/chat/$roomId'));
    return response.body;
  }

  Future<String> createRoom(String from, String to) async {
    var response = await http.post(Uri.parse('$url/api/room'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{'from': from, 'to': to}));
    return response.body;
  }


}
