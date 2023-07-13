import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_laboratory/src/modules/logging/widgets/logging_appbar.dart';
import 'package:flutter_laboratory/src/modules/main/controller/main_provider.dart';
import 'package:flutter_laboratory/src/shared/utils/extensions/context_extensions.dart';

class LoggingPage extends StatelessWidget {
  const LoggingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainProvider, MainState>(
      builder: (context, state) {
        final provider = context.watch<MainProvider>();
        String logLevel(int level) {
          // return string according to range
          if (level == 0) return 'ALL';
          if (level > 0 && level < 300) return 'FINEST';
          if (level >= 300 && level < 400) return 'FINER';
          if (level >= 400 && level < 500) return 'FINE';
          if (level >= 500 && level < 700) return 'CONFIG';
          if (level >= 700 && level < 800) return 'INFO';
          if (level >= 800 && level < 900) return 'WARNING';
          if (level >= 900 && level < 1000) return 'SEVERE';
          if (level >= 1000 && level < 1200) return 'SHOUT';
          if (level >= 1200 && level < 2000) return 'OFF';
          return 'ALL';
        }

        return Scaffold(
          appBar: const LogsAppBar(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Dio().get('https://jsonplaceholder.typicode.com/todos/1');
              log(0.toString(), name: 'LoggingPage');
            },
            child: Icon(
              provider.loggingEnabled ? Icons.stop : Icons.play_arrow,
            ),
          ),
          body: Center(
            child: Row(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: provider.scrollController,
                    itemCount: provider.logs.length,
                    itemBuilder: (context, index) {
                      final log = provider.logs[index];
                      return Text.rich(
                        TextSpan(
                          style: const TextStyle(fontSize: 18),
                          children: [
                            TextSpan(
                              text: log.time,
                              style: TextStyle(color: context.colors.outline),
                            ),
                            const TextSpan(text: ' '),
                            TextSpan(
                              text: '[${logLevel(log.level)}]',
                              style: TextStyle(color: context.colors.outline),
                            ),
                            const TextSpan(text: ' '),
                            TextSpan(text: log.message),
                          ],
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
