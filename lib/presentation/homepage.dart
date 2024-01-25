import 'package:bootcampday6_chatroom_app_24jan/domain/usecases/get_username.dart';
import 'package:flutter/material.dart';
import 'package:bootcampday6_chatroom_app_24jan/presentation/login.dart';
import 'package:bootcampday6_chatroom_app_24jan/presentation/chatroom.dart';

import '../domain/usecases/get_room.dart';
import 'helper.dart';

class HomePage extends StatefulWidget {

  final String username;
  const HomePage({Key? key, required this.username}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

 List<String> listChat = [];
 List<String> roomList = [];
 Map<String, List<Map<String, dynamic>>> roomMessages = {};

 @override
 void initState() {
   super.initState();
   GetUsername().execute(widget.username).then((result) {
     setState(() {
       roomList = result.cast<String>();
     });
   });
 }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        title: Text('Welcome ${widget.username}, Lets Chat'),
      ),
        body : Container(
          height: MediaQuery.of(context).size.height - kToolbarHeight,
          padding: EdgeInsets.all(20),
          child: FutureBuilder<List>(
              future: GetRoom().execute(widget.username),
              builder: (context, snapshot){

                if (snapshot.hasData){
                  var listChat = snapshot.data!;
                  return ListView (
                      children: List.generate(listChat.length, (i) {
                        return InkWell(
                          onTap: (){
                            // print(snapshot.data);
                            // print('roomId: ${listChat[i]['roomId']}');
                            // print('roomId2: ${listChat[i]}');
                            // print('roomId3: ${listChat}');
                            // print(listChat[i]['users'][0]);
                            // String roomIdAtIndex = roomId[i];
                            // print (roomList[i]);
                            // print (widget.username);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ChatRoomPage(
                                  roomId: roomList[i],
                                  username: listChat[i]['users'][1],
                                )));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 24.0,
                                  backgroundColor: Colors.green,
                                  child: Text(
                                    listChat[i]['users'][1] != null ? listChat[i]['users'][1][0].toUpperCase() : '',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16.0), // Menambahkan jarak antara CircleAvatar dan Expanded
                                Expanded(
                                  flex: 5,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${listChat[i]['users'][1]}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text('${listChat[i]['messages'][listChat[i]['messages'].length - 1]['text']}'),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 8.0), // Menambahkan jarak antara Expanded dan Text
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    listChat[i]['messages'].isNotEmpty
                                        ? timestampConvert(int.parse(listChat[i]['messages'].last['timestamp']))
                                        : 'No messages available',
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                              ],
                            ),
                          ),

                        );
                      })
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                } else {
                  return const Text('Belum ada chat');
                }
              }
          ),
        ),
     floatingActionButton: FloatingActionButton(
       onPressed: () {
         print('New Message Button Clicked');
       },
       child: Icon(Icons.message,
           color: Colors.white,
       ),
       backgroundColor: Colors.green,
     ),
     floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
 }
}


    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text(''),
    //   ),
    //   body: Container(
    //     height: MediaQuery.of(context).size.height - kToolbarHeight,
    //     child: FutureBuilder<List>(
    //         future: GetRoom().execute(widget.username),
    //         builder: (context, snapshot) {
    //           if (snapshot.hasData) {
    //             var listChat = snapshot.data!;
    //             return ListView(
    //               children: List.generate(listChat.length, (i) {
    //                 return InkWell(
    //                   onTap: () {
    //                     Navigator.of(context).push(MaterialPageRoute(
    //                         builder: (context) => ChatRoom()));
    //                   },
    //                   child: Card(
    //                     child: Column(
    //                       children: [
    //                         Text(
    //                           '${listChat[i]['users'][1]}',
    //                           style:
    //                           const TextStyle(fontWeight: FontWeight.bold),
    //                         ),
    //                         Text(
    //                             '${listChat[i]['messages'][listChat[i]['messages'].length - 1]['text']}')
    //                       ],
    //                     ),
    //                   ),
    //                 );
    //               }),
    //             );
    //           } else if (snapshot.hasError) {
    //             return Text('${snapshot.error}');
    //           } else {
    //             return const Text('Belum ada chat');
    //           }
    //         }),
    //   ),
    //   floatingActionButton: FloatingActionButton(
    //     onPressed: () {},
    //     tooltip: 'Chat baru',
    //     child: const Icon(Icons.add),
    //   ),
    // );}}