import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_laboratory/src/shared/service/vm_service.dart';

part 'main_state.dart';

class MainProvider extends Cubit<MainState> {
  MainProvider() : super(MainStateInitial());
  final service = AppVMService.i;
}
