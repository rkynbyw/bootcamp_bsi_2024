import 'dart:convert';

import 'package:bootcampday6_chatroom_app_24jan/data/datasource.dart';
import 'package:bootcampday6_chatroom_app_24jan/domain/entities/username.dart';
import 'package:bootcampday6_chatroom_app_24jan/domain/entities/chatroom.dart';

var meChatDatasource = MeChatDatasource();

// class UsernameRepository{
//   Future<List<Username>> getUsername(String username) async {
//     var jsonArray = jsonDecode(await meChatDatasource.getUsername(username))['data'];
//     var listUsername = <Username>[];
//     for (var i=0; i < jsonArray.length; i++){
//       listUsername.add(Username.fromJson(jsonArray[i]));
//     }
//     return listUsername;
//   }
// }

class ChatRepository {

  Future<List> getUsername(String username) async {
    var jsonArray =
      jsonDecode(await meChatDatasource.getUsername(username))['data'];
    var listChat = jsonArray['rooms'];
    return listChat;
  }

  Future<List> getRoom(String username) async {
    var listChatRoom =
      jsonDecode(await meChatDatasource.getRoom(username))['data'];
    print(listChatRoom[0]);
    return listChatRoom;
  }
}