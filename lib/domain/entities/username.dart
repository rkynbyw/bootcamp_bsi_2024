class Username{
  final String username;
  final List<String> rooms;

  Username({
    required this.username,
    required this.rooms
  });

  factory Username.fromJson(Map<String, dynamic> json){
    return Username(
      username: json['username'],
      rooms: List<String>.from(json['rooms'])
    );
  }
}