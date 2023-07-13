class LogModel {
  final String message;
  final String? loggerName;
  final int level;
  final String? time;

  LogModel({
    required this.message,
    this.loggerName,
    this.level = 0,
    this.time,
  });

  @override
  String toString() {
    return 'LogModel(message: $message, loggerName: $loggerName, level: $level, time: $time)';
  }
}
