import 'package:bootcampday6_chatroom_app_24jan/domain/usecases/get_username.dart';
import 'package:flutter/material.dart';
import 'package:bootcampday6_chatroom_app_24jan/presentation/login.dart';

import '../domain/usecases/get_room.dart';

class ChatRoom extends StatefulWidget {
  // final Map<String, dynamic> chatRoom;
  // const ChatRoom({Key? key, required this.chatRoom}) : super(key: key);

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chatroom'),
      ),
      body: Center(
        child: Text('Ini Chat Room Page'),
      ),
    );
  }
}
