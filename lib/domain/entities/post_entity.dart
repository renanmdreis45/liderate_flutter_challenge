class PostEntity {
  final String id;
  final String title;
  final String description;
  final DateTime scheduledDate;

  PostEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.scheduledDate,
  });

  bool isValid() {
    return title.isNotEmpty &&
        description.isNotEmpty &&
        scheduledDate.isAfter(DateTime.now());
  }
}
