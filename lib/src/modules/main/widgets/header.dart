import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_laboratory/src/modules/main/controller/main_provider.dart';
import 'package:flutter_laboratory/src/modules/main/widgets/header_icon.dart';
import 'package:flutter_laboratory/src/modules/main/widgets/uptime_text.dart';

class MainVMHeader extends StatelessWidget {
  const MainVMHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MainProvider>();
    final vm = provider.service.dartVm;

    return DrawerHeader(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderIcon(vm.operatingSystem!.toLowerCase()),
          const SizedBox(width: 8.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                vm.operatingSystem!,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              Text('${vm.hostCPU} | ${vm.targetCPU}'),
              Text('Dart: ${vm.version?.split(' ').first}'),
              TimeWidget(startTime: vm.startTime!),
              Text(
                provider.service.isInitialized ? 'Online' : 'Offline',
                style: TextStyle(
                  color: provider.service.isInitialized
                      ? Colors.green
                      : Colors.red,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
