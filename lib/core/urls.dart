class Urls {
  static const String _baseUrl = 'https://task-manager-backend-flutter.vercel.app/api/v1';

  static const String registrationUrl = '$_baseUrl/users/createUser';
  static const String loginUrl = '$_baseUrl/auth/login';
  static const String addNewTaskUrl = '$_baseUrl/getAllTask/createTask';
  static const String newTaskListUrl = '$_baseUrl/getAllTask/status/New';
  static const String progressTaskListUrl =
      '$_baseUrl/getAllTask/status/Progress';
  static const String cancelledTaskListUrl =
      '$_baseUrl/getAllTask/status/Cancelled';
  static const String completedTaskListUrl =
      '$_baseUrl/getAllTask/status/Completed';
  static String deleteTaskUrl(String id) => '$_baseUrl/getAllTask/$id';
  static String updateTaskStatusUrl(String id, String newStatus) =>
      '$_baseUrl/getAllTask/$id/$newStatus';
  static const String updateProfileUrl = '$_baseUrl/users/profileUpdate';
  static const String taskStatusCountUrl =
      '$_baseUrl/getAllTask/taskStatusCount';
}
