import 'package:liderate_flutter_challenge/domain/entities/post_entity.dart';

class PostModel {
  final String id;
  final String title;
  final String description;
  final DateTime scheduledDate;

  PostModel({
    required this.id,
    required this.title,
    required this.description,
    required this.scheduledDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'scheduledDate': scheduledDate.toIso8601String(),
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      scheduledDate: DateTime.parse(map['scheduledDate']),
    );
  }

  PostEntity toEntity() {
    return PostEntity(
      id: id,
      title: title,
      description: description,
      scheduledDate: scheduledDate,
    );
  }

  factory PostModel.fromEntity(PostEntity entity) {
    return PostModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      scheduledDate: entity.scheduledDate,
    );
  }
}
