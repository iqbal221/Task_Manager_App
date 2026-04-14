import 'package:intl/intl.dart';

String formatDate(String? dateString) {
  if (dateString == null || dateString.isEmpty) {
    return "No Date";
  }

  try {
    DateTime dateTime = DateTime.parse(dateString);
    return DateFormat('dd-MM-yyyy').format(dateTime);
  } catch (e) {
    return "Invalid Date";
  }
}
