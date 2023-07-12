import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_laboratory/src/shared/service/vm_service.dart';

part 'connect_state.dart';

class ConnectProvider extends Cubit<ConnectState> {
  ConnectProvider() : super(ConnectState.initial);

  String? host;

  final formKey = GlobalKey<FormState>();

  void setHost(String? host) => this.host = host;

  Future<void> connect([_]) async {
    if (formKey.currentState == null) return;
    if (formKey.currentState!.validate()) {
      emit(ConnectState.connecting);
      try {
        await AppVMService.i.initialize(host!);
        emit(ConnectState.connected);
      } catch (e) {
        emit(ConnectState.error);
      }
    }
  }
}
