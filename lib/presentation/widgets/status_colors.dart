import 'package:flutter/material.dart';

class StatusColors {
  static Color getStatusColor(String status) {
    switch (status) {
      case 'New':
        return Colors.blue;
      case 'Progress':
        return Colors.orange;
      case 'Cancelled':
        return Colors.red;
      case 'Completed':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
