import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_laboratory/src/shared/data/models/log.dart';
import 'package:flutter_laboratory/src/shared/service/vm_events_parser.dart';
import 'package:flutter_laboratory/src/shared/service/vm_service.dart';
import 'package:vm_service/vm_service.dart';

part 'main_state.dart';

class MainProvider extends Cubit<MainState> {
  MainProvider() : super(MainStateInitial());
  final service = AppVMService.i;

  bool get loggingEnabled => service.listenedEvents.contains('Logging');

  String logLevel = 'All';

  final logs = <LogModel>[];
  StreamSubscription<LogModel>? streamSub;

  final scrollController = ScrollController();

  void _scrollToBottom() {
    return scrollController.jumpTo(
      scrollController.position.maxScrollExtent,
    );
  }

  void clearLogs() {
    logs.clear();
    emit(MainStateUpdated());
  }

  void setLogLevel(String? value) {
    logLevel = value!;
    emit(MainStateUpdated());
  }

  Future<void> toggleLogging(_) async {
    if (!loggingEnabled) {
      await service.streamListen(EventStreams.kLogging);
      streamSub = EventParser().onLog.listen((log) {
        logs.add(log);
        emit(MainStateUpdated());
        _scrollToBottom();
      });
    } else {
      await service.streamCancel(EventStreams.kLogging);
      await streamSub?.cancel();
      streamSub = null;
    }
    emit(MainStateUpdated());
  }
}
