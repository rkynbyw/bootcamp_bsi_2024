import 'package:bootcampday6_chatroom_app_24jan/domain/usecases/get_username.dart';
import 'package:flutter/material.dart';
import 'package:bootcampday6_chatroom_app_24jan/presentation/login.dart';

import '../domain/usecases/get_chat.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'helper.dart';

class ChatBubble extends StatelessWidget {
  final String senderName;
  final String message;
  final String timestamp;
  final bool isMe;

  ChatBubble({
    required this.senderName,
    required this.message,
    required this.timestamp,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: ListTile(
        title: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isMe ? Colors.blue : Colors.grey,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                senderName,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                message,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                timestamp,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
        tileColor: isMe ? Colors.blue : Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: EdgeInsets.all(0),
        visualDensity: VisualDensity.compact,
        horizontalTitleGap: 0,
        minVerticalPadding: 0,
        minLeadingWidth: 0,
        leading: isMe
            ? null
            : CircleAvatar(
          backgroundColor: Colors.white,
          child: Text(
            senderName.isNotEmpty ? senderName[0].toUpperCase() : '',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isMe ? Colors.blue : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}

class ChatRoomPage extends StatefulWidget {
  final String roomId;
  final String username;

  const ChatRoomPage({Key? key, required this.roomId, required this.username})
      : super(key: key);

  @override
  ChatRoomPageState createState() => ChatRoomPageState();
}

class ChatRoomPageState extends State<ChatRoomPage> {
  List<Map<String, dynamic>> messages = [];
  final messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getMessages();
    // _sendMessage();
  }

  _getMessages() async {
    final response = await http
        .get(Uri.parse('http://127.0.0.1:8080/api/chat/${widget.roomId}'));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['data'] != null) {
        setState(() {
          messages = List<Map<String, dynamic>>.from(data['data']['messages']);
          for (var message in messages) {
            if (message['timestamp'] is String) {
              message['timestamp'] = int.parse(message['timestamp']);
            }
          }
          // Sort messages in descending order of timestamp
          messages.sort((b, a) => b['timestamp'].compareTo(a['timestamp']));
        });
      } else {
        // handle the case when 'data' is null
        messages = [];
      }
    } else {
      throw Exception('Failed to load messages for room ${widget.roomId}');
    }
  }

  _sendMessage() async {
    if (messageController.text.isNotEmpty) {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8080/api/chat'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'id': widget.roomId,
          'username': widget.username,
          'text': messageController.text,
        }),
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['data'] == true) {
          setState(() {
            messages.insert(0, {
              'username': widget.username,
              'text': messageController.text,
              'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
            });
            messageController.clear();
          });
        } else {
          // handle the case when 'data' is not true
        }
      } else {
        throw Exception('Failed to send message');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.username}'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                var message = messages[index];
                return ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  leading: CircleAvatar(
                    radius: 24.0,
                    backgroundColor: Colors.green,
                    child: Text(
                      message['username'] != null ? message['username'][0].toUpperCase() : '',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Text(
                    '${message['username']}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      '${message['text']}',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  trailing: Text(
                    timestampConvert(int.parse('${message['timestamp']}')),
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey,
                    ),
                  ),
                );

              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Stack(
              children: [
                TextField(
                  controller: messageController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    labelText: 'Message',
                  ),
                ),
                Positioned(
                  right: 10.0,
                  bottom: 14.0,

                  child: ElevatedButton.icon(
                    onPressed: () {
                      _sendMessage();
                    },
                    icon: Icon(
                      Icons.send,
                      color: Colors.white,
                    ), // Icon send
                    label: Text('Send',
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
