class Logger {
  static void debug(String message) {
    print('[DEBUG] $message');
  }

  static void error(String message, {dynamic error, StackTrace? stackTrace}) {
    print('[ERROR] $message');
    if (error != null) print(error);
    if (stackTrace != null) print(stackTrace);
  }
}