import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_laboratory/src/shared/service/vm_service.dart';

part 'main_state.dart';

class MainProvider extends Cubit<MainState> {
  MainProvider() : super(MainStateInitial()) {
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        final time = DateTime.now().difference(
          DateTime.fromMillisecondsSinceEpoch(service.dartVm.startTime!),
        );
        // parse it to be in seconds and in mins and in hours

        if (time.inSeconds > 0 && time.inSeconds < 60) {
          t = '${time.inSeconds} seconds';
          emit(MainStateInitial());
        } else if (time.inMinutes > 0 && time.inMinutes < 60) {
          t = '${time.inMinutes} minutes';
          emit(MainStateInitial());
        } else if (time.inHours > 0 && time.inHours < 24) {
          t = '${time.inHours} hours';
          emit(MainStateInitial());
        } else {
          t = 'less than a second';
          emit(MainStateInitial());
        }
      },
    );
  }

  final service = AppVMService.i;

  String t = '';
}
