import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_laboratory/src/modules/connect/connect_screen.dart';
import 'package:flutter_laboratory/src/modules/connect/controller/connect_provider.dart';

class ConnectRoute extends GoRoute {
  ConnectRoute()
      : super(
          path: '/connect',
          builder: (context, state) => BlocProvider(
            create: (context) => ConnectProvider(),
            child: const ConnectScreen(),
          ),
        );
}
