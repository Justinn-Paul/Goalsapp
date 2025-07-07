class Validators {
  // Email validation
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    // Basic email regex pattern
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  // Password validation
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }

    return null;
  }

  // Goal title validation
  static String? validateGoalTitle(String? value) {
    if (value == null || value.isEmpty) {
      return 'Goal title is required';
    }

    if (value.length < 3) {
      return 'Goal title must be at least 3 characters long';
    }

    if (value.length > 100) {
      return 'Goal title must be less than 100 characters';
    }

    return null;
  }

  // Goal description validation
  static String? validateGoalDescription(String? value) {
    if (value == null || value.isEmpty) {
      return 'Goal description is required';
    }

    if (value.length < 10) {
      return 'Goal description must be at least 10 characters long';
    }

    if (value.length > 500) {
      return 'Goal description must be less than 500 characters';
    }

    return null;
  }

  // Category validation
  static String? validateCategory(String? value) {
    if (value == null || value.isEmpty) {
      return 'Category is required';
    }

    return null;
  }

  // Status validation
  static String? validateStatus(String? value) {
    if (value == null || value.isEmpty) {
      return 'Status is required';
    }

    return null;
  }

  // Priority validation
  static String? validatePriority(String? value) {
    if (value == null || value.isEmpty) {
      return 'Priority is required';
    }

    return null;
  }

  // Date validation
  static String? validateDate(DateTime? value) {
    if (value != null && value.isBefore(DateTime.now())) {
      return 'Target date cannot be in the past';
    }

    return null;
  }

  // General required field validation
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }

    return null;
  }

  // Length validation
  static String? validateLength(
    String? value,
    int minLength,
    int maxLength,
    String fieldName,
  ) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }

    if (value.length < minLength) {
      return '$fieldName must be at least $minLength characters long';
    }

    if (value.length > maxLength) {
      return '$fieldName must be less than $maxLength characters';
    }

    return null;
  }
}
