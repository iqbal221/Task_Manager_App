class TaskModel {
  final String id;
  final String title;
  final String description;
  final String status;
  final String email;
  final String? createdAt;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.email,
    this.createdAt,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] ?? json['_id'] ?? "",
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      status: json['status'] ?? '',
      email: json['email'] ?? '',
      createdAt: json['createdAt'],
    );
  }
}
