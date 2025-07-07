class AppConstants {
  // App Colors
  static const String primaryColor = '#2196F3';
  static const String secondaryColor = '#FF9800';
  static const String successColor = '#4CAF50';
  static const String errorColor = '#F44336';
  static const String warningColor = '#FFC107';

  // Goal Categories
  static const List<String> goalCategories = [
    'Personal',
    'Career',
    'Health',
    'Education',
    'Financial',
    'Relationships',
    'Spiritual',
    'Other',
  ];

  // Goal Status
  static const List<String> goalStatuses = [
    'Not Started',
    'In Progress',
    'Completed',
    'On Hold',
  ];

  // Goal Priorities
  static const List<String> goalPriorities = [
    'Low',
    'Medium',
    'High',
    'Critical',
  ];

  // Firebase Collections
  static const String usersCollection = 'users';
  static const String goalsCollection = 'goals';

  // Shared Preferences Keys
  static const String userIdKey = 'user_id';
  static const String userEmailKey = 'user_email';
  static const String userDisplayNameKey = 'user_display_name';

  // Error Messages
  static const String networkError =
      'Network error. Please check your connection.';
  static const String authError = 'Authentication failed. Please try again.';
  static const String generalError = 'Something went wrong. Please try again.';

  // Success Messages
  static const String goalAddedSuccess = 'Goal added successfully!';
  static const String goalUpdatedSuccess = 'Goal updated successfully!';
  static const String goalDeletedSuccess = 'Goal deleted successfully!';
  static const String loginSuccess = 'Login successful!';
  static const String signupSuccess = 'Account created successfully!';

  // Validation Messages
  static const String titleRequired = 'Title is required';
  static const String descriptionRequired = 'Description is required';
  static const String categoryRequired = 'Category is required';
  static const String statusRequired = 'Status is required';
  static const String priorityRequired = 'Priority is required';
  static const String emailRequired = 'Email is required';
  static const String passwordRequired = 'Password is required';
  static const String invalidEmail = 'Please enter a valid email';
  static const String passwordTooShort =
      'Password must be at least 6 characters';

  // App Text
  static const String appTitle = 'Goals App';
  static const String homeTitle = 'My Goals';
  static const String addGoalTitle = 'Add New Goal';
  static const String editGoalTitle = 'Edit Goal';
  static const String loginTitle = 'Login';
  static const String signupTitle = 'Sign Up';
  static const String profileTitle = 'Profile';
  static const String settingsTitle = 'Settings';

  // Button Text
  static const String addButton = 'Add Goal';
  static const String saveButton = 'Save';
  static const String cancelButton = 'Cancel';
  static const String deleteButton = 'Delete';
  static const String editButton = 'Edit';
  static const String loginButton = 'Login';
  static const String signupButton = 'Sign Up';
  static const String logoutButton = 'Logout';

  // Placeholder Text
  static const String titlePlaceholder = 'Enter goal title';
  static const String descriptionPlaceholder = 'Enter goal description';
  static const String emailPlaceholder = 'Enter your email';
  static const String passwordPlaceholder = 'Enter your password';
  static const String searchPlaceholder = 'Search goals...';
}
