class Chat{
  late final String sender;
  late final String messages;
  late final String timestamp;

  Chat({
    required this.sender,
    required this.messages,
    required this.timestamp
  });

  factory Chat.fromJson(Map<String, dynamic> json){
    return Chat(
        sender: json['username'] as String,
        messages: json['text'] as String,
        timestamp: json['timestamp'] as dynamic
    );
  }

  Map <String, dynamic> toJson(){
    return {
      'sender' : sender,
      'messages' : messages,
      'timestamp' : timestamp
    };
  }
}