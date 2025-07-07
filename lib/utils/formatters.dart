import 'package:intl/intl.dart';

class Formatters {
  // Format date for display
  static String formatDate(DateTime date) {
    return DateFormat('MMM dd, yyyy').format(date);
  }

  // Format date and time for display
  static String formatDateTime(DateTime date) {
    return DateFormat('MMM dd, yyyy HH:mm').format(date);
  }

  // Format relative time (e.g., "2 days ago")
  static String formatRelativeTime(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago';
    } else {
      return 'Just now';
    }
  }

  // Format priority for display
  static String formatPriority(String priority) {
    switch (priority.toLowerCase()) {
      case 'low':
        return 'Low';
      case 'medium':
        return 'Medium';
      case 'high':
        return 'High';
      case 'critical':
        return 'Critical';
      default:
        return priority;
    }
  }

  // Format status for display
  static String formatStatus(String status) {
    switch (status.toLowerCase()) {
      case 'not started':
        return 'Not Started';
      case 'in progress':
        return 'In Progress';
      case 'completed':
        return 'Completed';
      case 'on hold':
        return 'On Hold';
      default:
        return status;
    }
  }

  // Format category for display
  static String formatCategory(String category) {
    return category.isNotEmpty ? category : 'Uncategorized';
  }

  // Get priority color
  static String getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'low':
        return '#4CAF50'; // Green
      case 'medium':
        return '#FF9800'; // Orange
      case 'high':
        return '#F44336'; // Red
      case 'critical':
        return '#9C27B0'; // Purple
      default:
        return '#757575'; // Gray
    }
  }

  // Get status color
  static String getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'not started':
        return '#757575'; // Gray
      case 'in progress':
        return '#2196F3'; // Blue
      case 'completed':
        return '#4CAF50'; // Green
      case 'on hold':
        return '#FF9800'; // Orange
      default:
        return '#757575'; // Gray
    }
  }

  // Format goal title for display (truncate if too long)
  static String formatTitle(String title, {int maxLength = 50}) {
    if (title.length <= maxLength) {
      return title;
    }
    return '${title.substring(0, maxLength)}...';
  }

  // Format goal description for display (truncate if too long)
  static String formatDescription(String description, {int maxLength = 100}) {
    if (description.length <= maxLength) {
      return description;
    }
    return '${description.substring(0, maxLength)}...';
  }
}
