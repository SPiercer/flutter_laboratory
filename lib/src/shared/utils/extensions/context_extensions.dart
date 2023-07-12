import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension ContextExtensions on BuildContext {
  GoRouterState get routerState => GoRouterState.of(this);

  ColorScheme get colors => Theme.of(this).colorScheme;

  Size get screenSize => MediaQuery.sizeOf(this);
}
