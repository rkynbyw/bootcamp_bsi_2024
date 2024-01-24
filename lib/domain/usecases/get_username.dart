import 'package:bootcampday6_chatroom_app_24jan/data/repository.dart';
import 'package:bootcampday6_chatroom_app_24jan/data/repository.dart';
import 'package:bootcampday6_chatroom_app_24jan/domain/entities/username.dart';

class GetUsername{
  var repository = ChatRepository();
  Future <List> execute(String username){
    return repository.getUsername(username);
  }
}