import 'package:bootcampday6_chatroom_app_24jan/domain/usecases/get_username.dart';
import 'package:flutter/material.dart';
import 'package:bootcampday6_chatroom_app_24jan/presentation/login.dart';
import 'package:bootcampday6_chatroom_app_24jan/presentation/chatroom.dart';

import '../domain/usecases/get_room.dart';

class HomePage extends StatefulWidget {

  final String username;
  const HomePage({Key? key, required this.username}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

 List<String> listChat = [];
 Map<String, List<Map<String, dynamic>>> roomMessages = {};

 @override
 void initState() {
   super.initState();
   GetUsername().execute(widget.username);
}

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        title: Text('Welcome User, Lets Chat'),
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
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ChatRoom()));
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Expanded(
                                    flex: 1,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(25.0), // Adjust the border radius as needed
                                      child: Image.network(
                                        'https://buffer.com/library/content/images/2023/10/free-images.jpg',
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                    flex: 5,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('${listChat[i]['users'][1]}'),
                                          Text('${listChat[i]['messages'][listChat[i]['messages'].length-1]['text']}')
                                        ],
                                      ),
                                    )
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Expanded(
                                      flex: 1,
                                      child: Text('${listChat[i]['messages'][listChat[i]['messages'].length - 1]['timestamp']}')
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

        )
    );}}


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