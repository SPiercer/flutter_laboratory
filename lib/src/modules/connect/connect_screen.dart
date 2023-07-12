import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_laboratory/src/modules/connect/controller/connect_provider.dart';
import 'package:flutter_laboratory/src/shared/utils/constants/strings.dart'
    as constants;
import 'package:go_router/go_router.dart';

class ConnectScreen extends StatelessWidget {
  const ConnectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'DevTools+ for Flutter and Dart',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: BlocConsumer<ConnectProvider, ConnectState>(
        listener: (context, state) {
          switch (state) {
            case ConnectState.connected:
              return context.go('/');
            case ConnectState.error:
              context.pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'An error occurred while connecting to the VM service.',
                  ),
                ),
              );
              return;
            case ConnectState.connecting:
              showDialog(
                context: context,
                builder: (context) => const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            default:
          }
        },
        builder: (context, state) {
          final provider = context.watch<ConnectProvider>();
          return Form(
            autovalidateMode: AutovalidateMode.always,
            key: provider.formKey,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Connect to a running app',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text(
                    'Enter a URL to a running Flutter or Dart application.',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.5,
                    child: TextFormField(
                      validator: (value) {
                        final regex = RegExp(constants.wsHostRegex);
                        if (value == null || value.isEmpty) {
                          return 'Please make sure to enter a host';
                        }
                        if (!regex.hasMatch(value)) {
                          return 'Please make sure to enter a valid host';
                        }
                        return null;
                      },
                      onFieldSubmitted: provider.connect,
                      onChanged: provider.setHost,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: '(e.g. ws://127.0.0.1:12345/authcode=/ws)',
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: provider.connect,
                    child: const Text('Connect'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
