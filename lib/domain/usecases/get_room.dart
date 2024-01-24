import 'package:bootcampday6_chatroom_app_24jan/data/repository.dart';
import 'package:bootcampday6_chatroom_app_24jan/data/repository.dart';
import 'package:bootcampday6_chatroom_app_24jan/domain/entities/username.dart';

class GetRoom{
  var repository = ChatRepository();
  Future <List> execute(String username){
    return repository.getRoom(username);
  }
}