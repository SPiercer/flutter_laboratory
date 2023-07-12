import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension WidgetExtensions on Widget {
  /// Returns a [Page] with the current widget as child with a [MaterialRouteTransition].
  Page get asPage => MaterialPage(child: this);

  /// Returns a [Page] with the current widget as child and no transition.
  Page get asNoTransitionPage => NoTransitionPage(child: this);
}
