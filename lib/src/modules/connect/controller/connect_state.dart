part of 'connect_provider.dart';

enum ConnectState {
  initial,
  connecting,
  connected,
  error('An error occurred while connecting to the VM service.');

  bool get isInitial => this == ConnectState.initial;
  bool get isConnecting => this == ConnectState.connecting;
  bool get isConnected => this == ConnectState.connected;
  bool get hasError => this == ConnectState.error;

  const ConnectState([this.errorMessage]);

  /// use only on error state
  final String? errorMessage;
}
