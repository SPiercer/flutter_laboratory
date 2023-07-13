import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_laboratory/src/modules/main/controller/main_provider.dart';
import 'package:flutter_laboratory/src/shared/utils/extensions/context_extensions.dart';

class LogsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const LogsAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight * 1.5 + 16);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MainProvider>();
    return Column(
      children: [
        SizedBox(
          height: preferredSize.height - 16,
          child: Row(
            children: [
              const SizedBox(width: 16),
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search log',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              const Spacer(),
              const Text('Listen to logs:'),
              Switch(
                value: provider.loggingEnabled,
                onChanged: provider.toggleLogging,
              ),
              const SizedBox(width: 16),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: context.colors.primaryContainer,
                ),
                child: DropdownButton<String>(
                  value: provider.logLevel,
                  underline: const SizedBox.shrink(),
                  onChanged: provider.setLogLevel,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  dropdownColor: context.colors.background,
                  items: const [
                    DropdownMenuItem(
                      value: 'All',
                      child: Text('All'),
                    ),
                    DropdownMenuItem(
                      value: 'Debug',
                      child: Text('Debug'),
                    ),
                    DropdownMenuItem(
                      value: 'Info',
                      child: Text('Info'),
                    ),
                    DropdownMenuItem(
                      value: 'Warning',
                      child: Text('Warning'),
                    ),
                    DropdownMenuItem(
                      value: 'Error',
                      child: Text('Error'),
                    ),
                    DropdownMenuItem(
                      value: 'Critical',
                      child: Text('Critical'),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              FilledButton(
                onPressed: provider.clearLogs,
                child: const Text('clear'),
              ),
              const SizedBox(width: 16),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}
