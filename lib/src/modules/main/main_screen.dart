import 'package:flutter/material.dart';
import 'package:flutter_laboratory/src/modules/main/widgets/header.dart';
import 'package:flutter_laboratory/src/shared/utils/extensions/context_extensions.dart';
import 'package:go_router/go_router.dart';

class MainScreen extends StatelessWidget {
  final Widget child;
  const MainScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final isLogsSelected = context.routerState.location == '/logging';
    return Scaffold(
      body: Row(
        children: [
          SizedBox(
            width: 300,
            child: Drawer(
              child: ListView(
                children: [
                  const MainVMHeader(),
                  ListTile(
                    selected: isLogsSelected,
                    selectedTileColor: isLogsSelected
                        ? context.colors.primaryContainer.withOpacity(.5)
                        : null,
                    leading: const Icon(Icons.list),
                    title: Text(
                      'Logs',
                      style: isLogsSelected
                          ? const TextStyle(fontWeight: FontWeight.bold)
                          : null,
                    ),
                    onTap: () => context.push('/logging'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.list),
                    title: const Text('Logs'),
                    onTap: () => context.push('/logging'),
                  ),
                ],
              ),
            ),
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}
