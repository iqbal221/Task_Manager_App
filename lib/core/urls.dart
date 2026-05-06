class Urls {
  static const String _baseUrl =
      'https://task-manager-backend-flutter.vercel.app/api/v1';

  static const String registrationUrl = '$_baseUrl/users/createUser';
  static const String loginUrl = '$_baseUrl/auth/login';
  static const String addNewTaskUrl = '$_baseUrl/task/createTask';
  static const String newTaskListUrl = '$_baseUrl/task/status/New';
  static const String progressTaskListUrl = '$_baseUrl/task/status/Progress';
  static const String cancelledTaskListUrl = '$_baseUrl/task/status/Cancelled';
  static const String completedTaskListUrl = '$_baseUrl/task/status/Completed';
  static String deleteTaskUrl(String id) => '$_baseUrl/task/$id';
  static String updateTaskStatusUrl(String id, String newStatus) =>
      '$_baseUrl/task/$id/$newStatus';
  static const String updateProfileUrl = '$_baseUrl/users/profileUpdate';
  static const String taskStatusCountUrl = '$_baseUrl/task/taskStatusCount';
}
