import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_laboratory/src/shared/service/vm_service.dart';

part 'connect_state.dart';

class ConnectProvider extends Cubit<ConnectState> {
  ConnectProvider() : super(ConnectState.initial);

  String? host;

  final formKey = GlobalKey<FormState>();

  dynamic error;

  void setHost(String? host) => this.host = host;

  Future<void> connect([_]) async {
    if (formKey.currentState == null) return;
    if (formKey.currentState!.validate() || kDebugMode) {
      emit(ConnectState.connecting);
      try {
        if (kDebugMode) {
          final service = await Service.getInfo();
          host = service.serverUri
              .toString()
              .replaceFirst('http', 'ws')
              .replaceAll('=/', '=/ws');
        }
        await AppVMService.i.initialize(host!);
        emit(ConnectState.connected);
      } catch (e) {
        error = e;
        emit(ConnectState.error);
      }
    }
  }
}
