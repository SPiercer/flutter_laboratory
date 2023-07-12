import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_laboratory/app/router/redirect.dart';
import 'package:go_router/go_router.dart';

class HomeRedirect extends GoRedirect {
  @override
  FutureOr<String?> call(BuildContext context, GoRouterState state) {
    if (state.location == '/') {
      return '/logging';
    }
    return null;
  }
}
