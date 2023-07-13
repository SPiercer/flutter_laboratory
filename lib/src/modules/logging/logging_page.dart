import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_laboratory/src/modules/main/controller/main_provider.dart';

class LoggingPage extends StatelessWidget {
  const LoggingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainProvider, MainState>(
      buildWhen: (previous, current) => current is! MainStateTimeUpdated,
      builder: (context, state) {
        log(state.toString());
        final provider = context.watch<MainProvider>();
        return Scaffold(
          body: Center(
            child: StreamBuilder(
              stream: provider.service.vmService.onLoggingEvent,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final event = snapshot.data!;
                  return Text(event.logRecord!.message!.toString());
                }
                return const Text('No data');
              },
            ),
          ),
        );
      },
    );
  }
}
