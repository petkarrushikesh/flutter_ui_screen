// models/photos_model.dart
class Photos {
  final String title;
  final String url;
  final int id;

  Photos({
    required this.title,
    required this.url,
    required this.id,
  });

  factory Photos.fromJson(Map<String, dynamic> json) {
    return Photos(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      url: json['url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'url': url,
    };
  }
}