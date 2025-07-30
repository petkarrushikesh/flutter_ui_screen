// models/Postcreate.dart
class Postcreate {
  final int id;
  final String title;
  final String body;
  final int userId;

  Postcreate({
    required this.id,
    required this.title,
    required this.body,
    required this.userId,
  });

  factory Postcreate.fromJson(Map<String, dynamic> json) {
    return Postcreate(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      userId: json['userId'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'userId': userId,
    };
  }
}