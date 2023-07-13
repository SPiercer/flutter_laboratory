import 'package:vm_service/vm_service.dart';
import 'package:vm_service/vm_service_io.dart' as vm_io;

class AppVMService {
  static final _instance = AppVMService._();
  factory AppVMService() => _instance;
  static AppVMService get i => _instance;
  AppVMService._();

  /// the instance of the vm service class
  late final VmService vmService;

  /// the instance of the dart vm class
  late final VM dartVm;

  /// the instance of the main isolate class
  late final Isolate mainIsolate;

  /// the list of events that are being actively listened to
  final listenedEvents = <String>{};

  /// the flag that indicates if the vm service is initialized or not
  bool isInitialized = false;

  /// the `init` connects to the vm service and gets the dart vm and main isolate
  /// ```dart
  /// await AppVMService.i.init(host);
  /// ```
  /// where [host] is the host address of the vm service
  Future<void> initialize(String host) async {
    vmService = await vm_io.vmServiceConnectUri(host);
    dartVm = await vmService.getVM();
    mainIsolate = await vmService.getIsolate(dartVm.isolates!.first.id!);
    isInitialized = true;
  }

  /// The `streamListen` subscribes to a stream in the VM. Once subscribed, the client will begin receiving events from the stream.
  ///
  /// Use stream ids from [EventStreams] class such as
  /// ```dart
  /// (EventStreams.kLogging) or (EventStreams.kStdout);
  /// ```
  ///
  /// see also [streamListenAll]
  Future<void> streamListen(String streamId) async {
    if (listenedEvents.contains(streamId)) return; // already listening
    listenedEvents.add(streamId);
    await vmService.streamListen(streamId);
  }

  /// The `streamListenAll` method subscribes to all available streams in the VM.
  ///
  /// see also [streamListen]
  ///
  /// referance: https://github.com/dart-lang/sdk/blob/main/runtime/vm/service/service.md#streamlisten
  Future<void> streamListenAll() async {
    await vmService.streamListen(EventStreams.kVM);
    await vmService.streamListen(EventStreams.kIsolate);
    await vmService.streamListen(EventStreams.kDebug);
    await vmService.streamListen(EventStreams.kProfiler);
    await vmService.streamListen(EventStreams.kGC);
    await vmService.streamListen(EventStreams.kExtension);
    await vmService.streamListen(EventStreams.kTimeline);
    await vmService.streamListen(EventStreams.kLogging);
    await vmService.streamListen(EventStreams.kService);
    await vmService.streamListen(EventStreams.kHeapSnapshot);
    await vmService.streamListen(EventStreams.kStdout);
    await vmService.streamListen(EventStreams.kStderr);
  }

  /// The `streamCancel` method cancels a stream subscription.
  ///
  /// Use stream ids from [EventStreams] class such as
  /// ```dart
  /// (EventStreams.kLogging) or (EventStreams.kStdout);
  /// ```
  Future<void> streamCancel(String streamId) async {
    if (!listenedEvents.contains(streamId)) return; // not listening
    listenedEvents.remove(streamId);
    await vmService.streamCancel(streamId);
  }

  /// The `streamCancelAll` method cancels all active stream subscriptions.
  ///
  /// see also [streamCancel]
  Future<void> streamCancelAll() async {
    for (final streamId in listenedEvents) {
      await vmService.streamCancel(streamId);
    }
  }

  /// The `enableHttpProfiling` method starts the HTTP requests profiler
  ///
  /// by default it uses the main isolate, to use a specific isolate, pass the isolate id
  Future<void> enableHttpProfiling([String? isolateId]) async {
    isolateId ??= mainIsolate.id!;
    await vmService.httpEnableTimelineLogging(isolateId);
  }

  /// The `disableHttpProfiling` method stops the HTTP requests profiler
  ///
  /// by default it uses the main isolate, to use a specific isolate, pass the isolate id
  Future<void> disableHttpProfiling([String? isolateId]) async {
    isolateId ??= mainIsolate.id!;
    await vmService.httpEnableTimelineLogging(isolateId, false);
  }

  /// The `getHttpProfile` method returns the HTTP requests profile
  Future<HttpProfile> getHttpProfile([String? isolateId]) async {
    isolateId ??= mainIsolate.id!;
    return await vmService.getHttpProfile(isolateId);
  }

  /// The `dispose` method closes the connection to the VM service.
  Future<void> dispose() async {
    await vmService.dispose();
    isInitialized = false;
  }
}
