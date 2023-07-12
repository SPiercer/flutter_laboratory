import 'package:go_router/go_router.dart';
import 'package:flutter_laboratory/src/modules/connect/connect_route.dart';
import 'package:flutter_laboratory/src/modules/main/main_screen.dart';

class AppRouter {
  static final _instance = AppRouter._();
  factory AppRouter() => _instance;
  static AppRouter get i => _instance;
  AppRouter._();

  final router = GoRouter(
    initialLocation: '/connect',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      ConnectRoute(),
    ],
  );
}
