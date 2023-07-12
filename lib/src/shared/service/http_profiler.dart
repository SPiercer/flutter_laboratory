import 'dart:async';

import 'package:flutter_laboratory/src/shared/service/vm_service.dart';
import 'package:vm_service/vm_service.dart';

class HttpProfiler {
  static final _instance = HttpProfiler._();
  factory HttpProfiler() => _instance;
  static HttpProfiler get i => _instance;
  HttpProfiler._();

  final _service = AppVMService.i;

  final requests = <HttpProfileRequest>[];

  Timer? _pollingTimer;

  Future<void> startListening() async {
    if (!_service.isInitialized) {
      throw Exception(
        'VM Service not initialized, did you forget AppVMService.i.init(host)?',
      );
    }
    await _service.enableHttpProfiling();
    _pollingTimer = Timer.periodic(const Duration(seconds: 1), _getProfiles);
  }

  Future<void> stopListening() async {
    if (!_service.isInitialized) {
      throw Exception(
        'VM Service not initialized, did you forget AppVMService.i.init(host)?',
      );
    }
    await _service.disableHttpProfiling();
    _pollingTimer?.cancel();
  }

  Future<void> _getProfiles(Timer timer) async {
    requests.clear();
    if (!_service.isInitialized) {
      timer.cancel();
      throw Exception(
        'VM Service not initialized, did you forget AppVMService.i.init(host)?',
      );
    }
    final profile = await _service.getHttpProfile();
    requests.addAll(profile.requests);
  }
}
