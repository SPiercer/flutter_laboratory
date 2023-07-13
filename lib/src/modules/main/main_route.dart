import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_laboratory/src/modules/logging/logging_route.dart';
import 'package:flutter_laboratory/src/modules/main/controller/main_provider.dart';
import 'package:flutter_laboratory/src/modules/main/main_screen.dart';
import 'package:go_router/go_router.dart';

class MainRoute extends StatefulShellRoute {
  MainRoute()
      : super.indexedStack(
          branches: [LoggingRoute()],
          builder: (context, state, child) => BlocProvider(
            create: (context) => MainProvider(),
            child: MainScreen(child: child),
          ),
        );
}
