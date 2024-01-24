class ChatRoom{
  late final String id;
  final List<String> roomDetail;

  ChatRoom({
    required this.id,
    required this.roomDetail
  });

  factory ChatRoom.fromJson(Map<String, dynamic> json){
    return ChatRoom(
        id: json['id'],
        roomDetail: List<String>.from(json['roomDetail'])
    );
  }
}