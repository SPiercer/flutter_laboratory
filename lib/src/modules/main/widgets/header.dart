import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_laboratory/src/modules/main/controller/main_provider.dart';

class MainVMHeader extends StatelessWidget {
  const MainVMHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MainProvider>();
    final vm = provider.service.dartVm;
    late final IconData icon;
    switch (vm.operatingSystem?.toLowerCase()) {
      case 'android':
        icon = Icons.phone_android;
        break;
      case 'ios':
        icon = Icons.phone_iphone;
        break;
      case 'macos':
        icon = Icons.laptop_mac;
        break;
      case 'linux':
        icon = Icons.laptop;
        break;
      case 'windows':
        icon = Icons.desktop_windows;
        break;
      default:
    }
    return DrawerHeader(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Icon(icon, size: 48),
          ),
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
              BlocBuilder<MainProvider, MainState>(
                buildWhen: (previous, current) =>
                    current is MainStateTimeUpdated,
                builder: (context, state) => Text('Uptime: ${provider.t}'),
              ),
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
