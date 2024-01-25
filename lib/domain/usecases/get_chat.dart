import 'package:bootcampday6_chatroom_app_24jan/data/repository.dart';
import 'package:bootcampday6_chatroom_app_24jan/domain/entities/chat.dart';

class GetChat{
  var repository = ChatRepository();
  Future <List> execute(String roomId){
    return repository.getChat(roomId);
  }
}