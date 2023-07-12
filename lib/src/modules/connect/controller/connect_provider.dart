import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'connect_state.dart';

class ConnectProvider extends Cubit<ConnectState> {
  ConnectProvider() : super(ConnectState.initial);

  String? host;

  final formKey = GlobalKey<FormState>();

  void setHost(String? host) => this.host = host;

  Future<void> connect([String? host]) async {
    if (formKey.currentState == null) return;
    if (formKey.currentState!.validate()) {
      emit(ConnectState.connecting);
      await Future.delayed(const Duration(seconds: 2));
      emit(ConnectState.connected);
    }
  }
}
