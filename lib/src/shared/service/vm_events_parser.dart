import 'dart:async';

import 'package:flutter_laboratory/src/shared/data/models/log.dart';
import 'package:flutter_laboratory/src/shared/service/vm_service.dart';

class EventParser {
  static final _instance = EventParser._();
  factory EventParser() => _instance;
  EventParser._();

  final _vmService = AppVMService.i.vmService;
  late final _loggingEvent = _vmService.onLoggingEvent;

  Stream<LogModel> get onLog => _loggingEvent.map<LogModel>((event) {
        final logRecord = event.logRecord!;

        final message = logRecord.message!.valueAsString!;
        final loggerName = logRecord.loggerName!.valueAsString!;
        final level = logRecord.level!;
        final time = logRecord.time!;

        return LogModel(
          message: message,
          loggerName: loggerName.isEmpty ? null : loggerName,
          level: level,
          time: DateTime.fromMillisecondsSinceEpoch(time)
              .toLocal()
              .toIso8601String()
              .substring(11),
        );
      });
}
