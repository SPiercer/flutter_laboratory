import 'package:flutter_laboratory/app/router/redirect.dart';
import 'package:flutter_laboratory/app/router/redirects/home_redirect.dart';
import 'package:flutter_laboratory/src/modules/main/main_route.dart';
import 'package:flutter_laboratory/src/modules/connect/connect_route.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final _instance = AppRouter._();
  factory AppRouter() => _instance;
  static AppRouter get i => _instance;
  AppRouter._();

  final router = GoRouter(
    initialLocation: '/connect',
    routes: [
      MainRoute(),
      ConnectRoute(),
    ],
    redirect: GoRedirect.compose([
      HomeRedirect(),
    ]),
  );
}
