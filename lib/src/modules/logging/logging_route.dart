import 'package:flutter_laboratory/src/modules/logging/logging_page.dart';
import 'package:flutter_laboratory/src/shared/utils/extensions/widget_extensions.dart';
import 'package:go_router/go_router.dart';

class LoggingRoute extends StatefulShellBranch {
  LoggingRoute()
      : super(
          routes: [_LoggingRoute()],
        );
}

class _LoggingRoute extends GoRoute {
  _LoggingRoute()
      : super(
          path: '/logging',
          pageBuilder: (context, state) =>
              const LoggingPage().asNoTransitionPage,
        );
}
