part of 'connect_provider.dart';

enum ConnectState {
  initial,
  connecting,
  connected,
  error('An error occurred while connecting to the VM service.');

  const ConnectState([this.errorMessage]);

  /// use only on error state
  final String? errorMessage;
}
